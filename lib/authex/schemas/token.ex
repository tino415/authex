defmodule Authex.Schemas.Token do
  use Domain.Schema

  alias Authex.Schemas

  import Joken.Config

  @derive {Jason.Encoder, only: [:access_token, :expires_in]}
  schema "tokens" do
    field :access_token, :string
    field :expires_in, :integer
    field :expires_at, :utc_datetime
    belongs_to(:client, Schemas.Client)

    timestamps()
  end

  def changeset(struct_or_changeset, client) do
    struct_or_changeset
    |> change(expires_in: 3600)
    |> put_now_moved_if_empty(:expires_at, 3600, :second)
    |> put_assoc(:client, client)
    |> generate_jwt_token_if_not_set()
    |> validate_required([:expires_in, :expires_at, :access_token])
  end

  defp generate_jwt_token_if_not_set(changeset) do
    case get_field(changeset, :access_token) do
      nil ->
        client = get_field(changeset, :client)

        {:ok, jwt, _claims} =
          %{}
          |> add_claim("iss", fn -> "http://localhost:4000" end, fn _ -> true end)
          |> add_claim("aud", fn -> client.id end, fn _ -> true end)
          |> add_claim("exp",
               fn -> get_field(changeset, :expires_at) end,
               fn exp -> :os.system_time() < exp end
          )
          |> Joken.generate_and_sign()

        put_change(changeset, :access_token, jwt)
      _ ->
        changeset
    end 
  end
end
