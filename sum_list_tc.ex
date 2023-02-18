defmodule ListHelper do
  def sum(list) do
    do_sum(0, list)
  end

  # cuando ya se vació la lista, se macha aquí y símplemente regresa el acumulador
  defp do_sum(current_sum, []) do
    current_sum
  end

  defp do_sum(current_sum, [head | tail]) do
    do_sum(current_sum + head, tail)
  end
end
