defmodule Authex.Schemas.Flow do
  use Domain.Schema

  alias Authex.Schemas

  import Ecto.Query

  @derive {Jason.Encoder, only: [:response, :code]}
  schema "flows" do
    field :response, Ecto.Enum, values: [:code, :none], default: :none
    # TODO: make url type
    field :redirect_uri, :string
    field :submitted_at, :utc_datetime
    field :code, :string, virtual: true
    field :code_hash, :string
    field :username, :string, virtual: true
    field :password, :string, virtual: true
    # TODO: add expires at and check it on refresh token

    belongs_to :client, Schemas.Client
    belongs_to :token, Schemas.Token
    belongs_to :user, Schemas.User

    timestamps(type: :utc_datetime)
  end

  def changeset(struct_or_schema, params) do
    struct_or_schema
    |> cast(params, [:client_id, :response, :redirect_uri, :username, :password])
    |> verify()
  end

  def submit_changeset(flow) do
    flow
    |> change()
    |> put_now(:submitted_at)
    |> verify()
  end

  def query_by_code(code) do
    # TODO: check if code is not already used
    # TODO: check if grant authorization timeout not expired
    from(
      c in __MODULE__,
      where: c.code_hash == ^Crypto.hash(code)
    )
  end

  defp verify(changeset) do
    changeset
    |> validate_inclusion(:response, [:code])
    |> validate_submit()
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

  defp validate_submit(changeset) do
    cond do
      not changed?(changeset, :submitted_at) ->
        changeset

      not is_nil(changeset.data.submitted_at) ->
        add_error(changeset, :submitted_at, "already submitted")

      is_nil(get_field(changeset, :user_id)) ->
        add_error(changeset, :user, "was not identified")

      true ->
        changeset
    end
  end
end
