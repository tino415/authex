# Authex

API only OAuth2 and OpenID server.

But more than that it is for me, author, of this project
to find solution for some repeating problems I had to deal with in
mi work. Also there is more stuff I wanted to try. For instance
use direct plug and ecto instead of phoenix. Instead of domain driven
design, have schema layer and context layer. Basically there is single
context in this app and schemas kind of cooperate together.

## Installation

Clone and `mix deps.get`, `mix ecto.create` and `mix ecto.migrate`.
Assumes `postgres` database with same name user and password.

## Issues

- I'm trying to follow CQRS and also to use changeset for most casting and validation
  but I think these things sometimes get in conflict. In this case I got to conflict
  when I was trying to validate creation of token. Because, in case o refresh token,
  I need casted refresh token from data to retrieve previous token to verify it validity,
  I resolved to what I always does, basically manually cast it in action (sort of controller)
  and pass selected token to changeset.

  Action:
  ```
  @impl true
  def create(conn, %{"code" => code} = params) do
    with %{} = flow <- Authex.get_flow_by_code_without_token(code) do
      do_create(conn, flow, params)
    else
      nil -> View.unauthorized(conn)
    end
  end

  def create(conn, %{"refresh_token" => refresh_token} = params) do
    with %{} = flow <- Authex.get_flow_by_refresh_token(refresh_token) do
      do_create(conn, flow, params)
    else
      nil -> View.unauthorized(conn)
    end
  end

  def create(conn, body_params) do
    do_create(conn, nil, body_params)
  end
  ```

- I always tried to use `put_assoc` so result after inserting contains that association and
  I don't need to return associated entity separately, but in this project it does not
  work. So I have this line after updating token:
  ```
    |> case do
      {:ok, client} -> {:ok, Repo.preload(client, scopes: :scope)}
      r -> r
    end
  ```

## TODO

- add tests
