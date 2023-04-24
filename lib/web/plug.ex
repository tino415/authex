defmodule Web.Plug do
  defmacro __using__(_opts) do
    quote do
      import Plug.Conn
    end
  end
end
