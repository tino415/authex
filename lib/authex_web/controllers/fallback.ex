defmodule AuthexWeb.Controllers.Fallback do
  use Web.Controller

  def not_found(conn) do
    json_resp(conn, 404, %{"error" => "not found"})
  end
end
