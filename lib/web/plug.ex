defmodule Web.Plug do
  defmacro __using__(_opts) do
    quote do
      import Plug.Conn

      import Web.Json
    end
  end
end
