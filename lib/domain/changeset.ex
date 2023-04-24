defmodule Domain.Changeset do
  import Ecto.Changeset

  def put_now_moved_if_empty(changeset, field, number, unit) do
    if get_field(changeset, field) do
      changeset
    else
      dt = 
        DateTime.utc_now()
        |> DateTime.truncate(:second)
        |> DateTime.add(number, unit)

      put_change(changeset, field, dt)
    end
  end

  def validate_fields_equal(changeset, first, second) do
    if get_field(changeset, first) == get_field(changeset, second) do
      changeset
    else
      add_error(changeset, second, "should be equal to %{field}", field: first)
    end
  end

  def generate_secret(changeset, field) do
    put_change(changeset, field, Crypto.generate_secret())
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
