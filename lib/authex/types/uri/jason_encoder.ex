defimpl Jason.Encoder, for: URI do
  def encode(%URI{} = uri, opts) do
    Jason.Encode.string(to_string(uri), opts)
  end
end
