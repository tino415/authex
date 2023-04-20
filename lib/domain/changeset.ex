defmodule Domain.Changeset do
  import Ecto.Changeset

  def validate_fields_equal(changeset, first, second) do
    if get_field(changeset, first) == get_field(changeset, second) do
      changeset
    else
      add_error(changeset, second, "should be equal to %{field}", field: first)
    end
  end

  def put_hashed(changeset, unhashed_field, target_field) do
    original = get_change(changeset, unhashed_field)

    if is_bitstring(original) do
      put_change(changeset, target_field, Crypto.hash(original))
    else
      changeset
    end
  end
end
