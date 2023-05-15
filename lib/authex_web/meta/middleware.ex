defmodule AuthexWeb.Meta.Middleware do
  defmacro __using__(_opts) do
    quote do
      alias AuthexWeb.View

      import Plug.Conn

      import AuthexWeb.Middleware
    end
  end
end
