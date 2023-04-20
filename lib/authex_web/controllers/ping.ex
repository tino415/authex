defmodule AuthexWeb.Controllers.Ping do
  use Web.Controller

  def ping(conn) do
    json_resp(conn, 200, %{"message" => "pong"})
  end
end
