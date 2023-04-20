defmodule Web.Router do
  defmacro __using__(_opts) do
    quote do
      use Plug.Router
    end
  end
end
