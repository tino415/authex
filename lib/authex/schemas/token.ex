defmodule Authex.Schemas.Token do
  use Domain.Meta.Schema

  @derive {Jason.Encoder, only: [:access_token, :expires_in, :scope]}
  schema "tokens" do
    field(:access_token, :string, virtual: true)
    field(:expires_in, :integer)
    field(:expires_at, :utc_datetime)
    field(:scope, :string, virtual: true)
    field(:scope_list, {:array, :string}, virtual: true)
    field(:grant_type, Ecto.Enum,
      values: [
        :client_credentials,
        :authorization_code,
        :refresh_token
      ])

    field(:refresh_token, :string)

    has_one(:flow, Schemas.Flow)
    belongs_to(:client, Schemas.Client)

    has_many(:token_scopes, Schemas.TokenScope)

    timestamps(type: :utc_datetime)
  end

  def changeset(struct_or_changeset, client, flow, body_params) do
    struct_or_changeset
    |> cast(body_params, [:scope, :grant_type, :refresh_token])
    |> change(expires_in: 3600)
    |> put_now_moved_if_empty(:expires_at, 3600, :second)
    |> put_assoc(:client, client)
    |> put_string_split_by_space(:scope, :scope_list)
    |> validate_required([:expires_in, :expires_at, :grant_type])
    |> validate_by_grant_type()
    |> resolve_flow(flow)
    |> generate_secret(:refresh_token)
    |> prepare_changes(& prepare_and_validate_scopes(&1, client))
  end

  def generate_access_token(token) do
    Map.put(token, :access_token, access_token_generate(token))
  end

  defp validate_by_grant_type(changeset) do
    case get_field(changeset, :grant_type) do
      :authorization_code -> validate_required(changeset, :code)
      :refresh_token -> validate_required(changeset, :refresh_token)
      _ -> changeset
    end
  end

  defp resolve_flow(changeset, flow) do
    if is_nil(flow) do
      validate_inclusion(changeset, :grant_type, [:client_credentials])
    else
      put_assoc(changeset, :flow, flow)
    end
  end

  defp prepare_and_validate_scopes(changeset, client) do
    if not changed?(changeset, :scope_list) do
      changeset
    else
      provided_scopes = get_change(changeset, :scope_list)
      existing_scopes = retrieve_scopes(changeset.repo, client.id, provided_scopes)
      existing_scopes_names = Enum.map(existing_scopes, & &1.name)
      changeset = validate_scopes_assigned(changeset, provided_scopes, existing_scopes_names)

      if not changeset.valid? do
        changeset
      else
        put_assoc(changeset, :token_scopes, cast_scopes(existing_scopes))
      end
    end
  end

  defp retrieve_scopes(repo, client_id, provided_scopes) do
    repo.all(
      Schemas.Scope.for_client_query(
        client_id,
        provided_scopes
      )
    )
  end

  defp validate_scopes_assigned(changeset, provided_scopes, existing_scopes_names) do
    Enum.reduce(provided_scopes, changeset, fn name, changeset ->
      if name in existing_scopes_names do
        changeset
      else
        add_error(changeset, :scope, "invalid scope %{scope}", scope: name)
      end
    end)
  end

  defp cast_scopes(existing_scopes) do
    Enum.map(existing_scopes, fn scope ->
      Schemas.TokenScope.changeset(%Schemas.TokenScope{}, scope)
    end)
  end

  defp access_token_generate(token) do
    Joken.generate_and_sign!(
      %{},
      %{
        "iss" => "http://localhost:4000",
        "aud" => token.client_id,
        "exp" => DateTime.to_unix(token.expires_at),
        "nbf" => DateTime.to_unix(token.inserted_at),
        "iat" => DateTime.to_unix(token.inserted_at),
        "jti" => token.id,
        "scope" => token.scope
      }
    )
  end
end
