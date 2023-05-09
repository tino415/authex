defmodule Domain.Meta.Schema do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      alias Authex.Schemas

      import Ecto.Changeset
      import Domain.Helpers.Changeset
      import Ecto.Query

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
