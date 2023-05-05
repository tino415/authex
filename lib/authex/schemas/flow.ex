defmodule Authex.Schemas.Flow do
  use Domain.Schema

  alias Authex.Schemas

  @derive {Jason.Encoder, only: [:grant_type, :code]}
  schema "flows" do
    field :grant_type, Ecto.Enum, values: [:authorization_code]
    # TODO: make url type
    field :redirect_uri, :string
    field :submitted_at, :utc_datetime
    field :code, :string, virtual: true
    field :code_hash, :string
    field :username, :string, virtual: true
    field :password, :string, virtual: true

    belongs_to :client, Schemas.Client
    belongs_to :token, Schemas.Token
    belongs_to :user, Schemas.User

    timestamps(type: :utc_datetime)
  end

  def changeset(struct_or_schema, params) do
    struct_or_schema
    |> cast(params, [:client_id, :grant_type, :redirect_uri, :username, :password])
    |> verify()
  end

  def submit_changeset(flow) do
    flow
    |> change()
    |> put_now(:submitted_at)
    |> verify()
  end

  defp verify(changeset) do
    changeset
    |> verify_user()
    |> generate_code()
  end

  defp verify_user(changeset) do
    if changed?(changeset, :username) and changed?(changeset, :password) do
      if not is_nil(get_field(changeset, :user_id)) do
        add_error(changeset, :password, "User already authorized")
      else
        prepare_changes(changeset, fn changeset ->
          user =
            changeset.repo.one(
              Schemas.User.query_by_username(
                get_change(changeset, :username)
              )
            )
            |> IO.inspect(label: "user")

          case user do
            nil ->
              add_error(changeset, :username, "Invalid password or unknown user")
            user ->
              if Schemas.User.password_valid?(user, get_change(changeset, :password)) do
                put_assoc(changeset, :user, user)
              else
                add_error(changeset, :username, "Invalid password or unknown user")
              end
          end
        end)
      end
    else
      changeset
    end
  end

  defp generate_code(changeset) do
    if changed?(changeset, :submitted_at) do
      changeset
      |> put_change(:code, Crypto.generate_secret())
      |> put_hashed(:code, :code_hash)
    else
      changeset
    end
  end
end
