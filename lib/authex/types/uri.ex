defmodule Authex.Types.URI do
  use Ecto.Type

  def type, do: :string

  def cast(uri), do: {:ok, URI.parse(uri)}

  def load(uri), do: {:ok, URI.parse(uri)}

  def dump(%URI{} = uri), do: {:ok, to_string(uri)}
end
