defmodule RangeIn do
  def get_range(a, b) when is_integer(a) and is_integer(b) and a < b do
    do_range([], a + 1, b)
  end

  # función para detener el loop(base case)
  defp do_range(range, _, b) when length(range) === (b - 2) do
    range
  end

  defp do_range(range, a, b) do
    new_number = length(range) + a
    range = Enum.concat(range, [new_number])
    do_range(range, a, b)
  end
end
