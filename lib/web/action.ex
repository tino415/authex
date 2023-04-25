defmodule Web.Action do
  @callback run(Plug.Conn.t(), any()) :: Plug.Conn.t()

  defmacro __using__(opts) do
    quote do
      use Plug.Builder

      import Web.Json

      @behaviour unquote(__MODULE__)

      unquote(Keyword.get(opts, :do))

      plug :run
    end
  end
end
