defmodule Domain.Helpers.Changeset do
  import Ecto.Changeset

  def put_now_moved_if_empty(changeset, field, number, unit) do
    if get_field(changeset, field) do
      changeset
    else
      dt = DateTime.add(datetime_now(), number, unit)
      put_change(changeset, field, dt)
    end
  end

  def put_now(changeset, field) do
    put_change(changeset, field, datetime_now())
  end

  def validate_fields_equal(changeset, first, second) do
    if get_field(changeset, first) == get_field(changeset, second) do
      changeset
    else
      add_error(changeset, second, "should be equal to %{field}", field: first)
    end
  end

  def generate_secret(changeset, field) do
    if is_nil(changeset.data.id) do
      put_change(changeset, field, Crypto.generate_secret())
    else
      changeset
    end
  end

  def put_string_split_by_space(changeset, from, to) do
    if changed?(changeset, from) do
      values =
        changeset
        |> get_change(from, "")
        |> String.trim()
        |> String.split(" ")

      put_change(changeset, to, values)
    else
      changeset
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

  defp datetime_now do
    DateTime.utc_now()
    |> DateTime.truncate(:second)
  end
end
