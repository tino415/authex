defmodule Web.Action.Get do
  @callback get(Plug.Conn.t(), any()) :: Plug.Conn.t()

  defmacro __using__(opts) do
    name = Keyword.get(opts, :name, "id")

    quote do
      use Web.Action, unquote(opts)

      @behaviour unquote(__MODULE__)

      def run(conn) do
        get(conn, conn.path_params[unquote(name)])
      end
    end
  end
end
