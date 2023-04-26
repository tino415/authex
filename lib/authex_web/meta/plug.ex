defmodule AuthexWeb.Meta.Plug do
  defmacro __using__(_opts) do
    quote do
      alias AuthexWeb.View

      import Plug.Conn

      import AuthexWeb.Plug
    end
  end
end
