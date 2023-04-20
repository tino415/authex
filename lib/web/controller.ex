defmodule Web.Controller do
  defmacro __using__(_opts) do
    quote do
      import Web.Json
    end
  end
end
