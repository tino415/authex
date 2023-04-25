defmodule Web.Action.List do
  @callback list(Plug.Conn.t(), map()) :: Plug.Conn.t()

  defmacro __using__(opts) do
    quote do
      use Web.Action, unquote(opts)

      @behaviour unquote(__MODULE__)

      def run(conn) do
        list(conn, conn.query_params)
      end
    end
  end
end
