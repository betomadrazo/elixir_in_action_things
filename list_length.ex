defmodule ListLength do
  def len(list) do
    do_len(0, list)
  end

  defp do_len(acc, []) do
    acc
  end
  defp do_len(acc, [_ | tail]) do
    do_len(acc + 1, tail)
  end
end
