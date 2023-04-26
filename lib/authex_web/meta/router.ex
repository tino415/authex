defmodule AuthexWeb.Meta.Router do
  defmacro __using__(opts) do
    quote do
      use Plug.Router

      alias AuthexWeb.Plugs
      alias AuthexWeb.Actions
      alias AuthexWeb.Routers

      unquote(Keyword.get(opts, :do))

      plug(:match)
      plug(:dispatch)
    end
  end
end
