defmodule Web.Action.Create do
  @callback create(Plug.Conn.t(), map()) :: Plug.Conn.t()

  defmacro __using__(opts) do
    quote do
      use Web.Action, unquote(opts)

      @behaviour unquote(__MODULE__)

      def run(conn) do
        create(conn, conn.body_params)
      end
    end
  end
end
