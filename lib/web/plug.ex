defmodule Web.Plug do
  defmacro __using__(_opts) do
    quote do
      alias AuthexWeb.View

      import Plug.Conn

      import Web.Json
    end
  end
end
