defmodule StrangeReduce do
  def strange() do
    Enum.reduce(
      [1, "not a number", 2, :x, 3],
      0,
      fn element, sum when is_number(element) ->
        sum + element
        _, sum -> # Este es el else de la clause
          sum
      end
    )
  end
end
