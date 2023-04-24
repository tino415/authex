defmodule Authex.Schemas.Token do
  use Domain.Schema

  alias Authex.Schemas

  @derive {Jason.Encoder, only: [:access_token, :expires_in]}
  schema "tokens" do
    field :access_token, :string, virtual: true
    field :expires_in, :integer
    field :expires_at, :utc_datetime
    belongs_to(:client, Schemas.Client)

    timestamps(type: :utc_datetime)
  end

  def changeset(struct_or_changeset, client) do
    struct_or_changeset
    |> change(expires_in: 3600)
    |> put_now_moved_if_empty(:expires_at, 3600, :second)
    |> put_assoc(:client, client)
    |> validate_required([:expires_in, :expires_at])
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
           "jti" => token.id
        }
      )

    Map.put(token, :access_token, access_token)
  end
end
