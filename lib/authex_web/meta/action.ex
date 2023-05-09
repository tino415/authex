defmodule AuthexWeb.Meta.Action do
  @callback run(Plug.Conn.t()) :: Plug.Conn.t()

  defmacro __using__(opts) do
    quote do
      use Plug.Builder

      alias AuthexWeb.View

      @behaviour unquote(__MODULE__)

      unquote(Keyword.get(opts, :do))

      plug(:do_run)

      def do_run(conn, _opts), do: run(conn)
    end
  end
end
