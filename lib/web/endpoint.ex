defmodule Web.Endpoint do
  defmacro __using__(_opts) do
    quote do
      use Plug.Builder
    end
  end
end
