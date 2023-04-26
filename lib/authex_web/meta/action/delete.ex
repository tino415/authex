defmodule AuthexWeb.Meta.Action.Delete do
  @callback delete(Plug.Conn.t(), any()) :: Plug.Conn.t()

  defmacro __using__(opts) do
    name = Keyword.get(opts, :name, "id")

    quote do
      use AuthexWeb.Meta.Action, unquote(opts)

      @behaviour unquote(__MODULE__)

      def run(conn) do
        delete(conn, conn.path_params[unquote(name)])
      end
    end
  end
end
