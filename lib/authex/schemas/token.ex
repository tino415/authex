defmodule Authex.Schemas.Token do
  use Domain.Schema

  alias Authex.Schemas

  @derive {Jason.Encoder, only: [:access_token, :expires_in, :scope]}
  schema "tokens" do
    field :access_token, :string, virtual: true
    field :expires_in, :integer
    field :expires_at, :utc_datetime
    field :scope, :string, virtual: true
    field :scope_list, {:array, :string}, virtual: true
    belongs_to(:client, Schemas.Client)

    has_many(:token_scopes, Schemas.TokenScope)

    timestamps(type: :utc_datetime)
  end

  def changeset(struct_or_changeset, client, body_params) do
    struct_or_changeset
    |> cast(body_params, [:scope])
    |> change(expires_in: 3600)
    |> put_now_moved_if_empty(:expires_at, 3600, :second)
    |> put_assoc(:client, client)
    |> create_scopes_list()
    |> validate_required([:expires_in, :expires_at])
    |> prepare_changes(fn changeset ->
      if changed?(changeset, :scope_list) do
        provided_scopes = get_change(changeset, :scope_list)

        existing_scopes =
          changeset.repo.all(
            Schemas.Scope.for_client_query(
              client.id,
              provided_scopes
            )
          )

        existing_scopes_names = Enum.map(existing_scopes, & &1.name)

        changeset =
          Enum.reduce(provided_scopes, changeset, fn name, changeset ->
            if name in existing_scopes_names do
              changeset
            else
              add_error(changeset, :scope, "invalid scope %{scope}", scope: name)
            end
          end)

        if not changeset.valid? do
          changeset
        else
          token_scopes =
            Enum.map(existing_scopes, fn scope ->
              Schemas.TokenScope.changeset(%Schemas.TokenScope{}, scope)
            end)

          put_assoc(changeset, :token_scopes, token_scopes)
        end
      else
        changeset
      end
    end)
  end

  def generate_access_token(token) do
    {:ok, access_token, _claims} =
      Joken.generate_and_sign(
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

    Map.put(token, :access_token, access_token)
  end

  defp create_scopes_list(changeset) do
    if changed?(changeset, :scope) do
      scope_list =
        changeset
        |> get_change(:scope)
        |> String.trim()
        |> String.split(" ")

      put_change(changeset, :scope_list, scope_list)
    else
      changeset
    end
  end
end
