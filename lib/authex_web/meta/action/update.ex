defmodule AuthexWeb.Meta.Action.Update do
  @callback update(Plug.Conn.t(), String.t(), map()) :: Plug.Conn.t()

  defmacro __using__(opts) do
    name = Keyword.get(opts, :name, "id")

    quote do
      use AuthexWeb.Meta.Action, unquote(opts)

      @behaviour unquote(__MODULE__)

      def run(conn) do
        update(conn, conn.query_params[unquote(name)], conn.body_params)
      end
    end
  end
end
