defmodule AuthexWeb.Actions.User.Update do
  use Web.Action.Update, name: "user_id"

  @impl true
  def update(conn, user_id, body_params) do
    case Authex.get_user(user_id) do
      nil -> View.not_found(conn)
      user ->
        case Authex.update_user(user, body_params) do
          {:ok, user} -> View.success(conn, user)
          _ -> View.invalid_request(conn)
        end
    end
  end
end
