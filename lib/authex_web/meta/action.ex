defmodule AuthexWeb.Meta.Action do
  @callback run(Plug.Conn.t()) :: Plug.Conn.t()

  alias AuthexWeb.View

  defmacro __using__(opts) do
    quote do
      use Plug.Builder

      alias AuthexWeb.View

      @behaviour unquote(__MODULE__)

      unquote(Keyword.get(opts, :do))

      plug(:do_run)

      def do_run(conn, _opts), do: unquote(__MODULE__).run(__MODULE__, conn)
    end
  end

  def run(module, conn) do
    case apply(module, :run, [conn]) do
      %Plug.Conn{} = conn ->
        conn

      nil ->
        View.not_found(conn)

      {:error, %Ecto.Changeset{} = changeset} ->
        View.invalid_request_changeset(conn, changeset)

      {:error, :build_in} ->
        View.invalid_request(conn, %{"error" => "Scope is build in"})
    end
  end
end
