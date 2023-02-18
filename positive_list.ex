defmodule Positives do
  def positive([]), do: []
  def positive([head | tail]) do
    [abs(head) | positive(tail)]
  end
end
