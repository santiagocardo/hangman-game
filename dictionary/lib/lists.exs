defmodule Lists do
  import Integer

  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def double([]), do: []
  def double([ head | tail ]), do: [ 2*head | double(tail) ]

  def even_length?(list), do: len(list) |> Integer.is_even

  def sum_pairs([]), do: []
  def sum_pairs([ h1, h2 | t]), do: [ h1 + h2 | sum_pairs(t) ]
end