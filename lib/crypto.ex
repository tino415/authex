defmodule Crypto do
  def hash(input) do
    :crypto.hash(:sha256, input)
    |> base64_url_encode()
  end

  defp base64_url_encode(string) do
    string
    |> Base.encode64()
    |> String.replace(~r/\+/, "-")
    |> String.replace(~r/\//, "_")
    |> String.replace(~r/=/, "")
  end
end
