defmodule Floor do
  def score("("), do: 1
  def score(")"), do: -1
  def score(_), do: 0

  def process([], total), do: total
  def process([head | tail], total), do: process(tail, score(head) + total)
end

IO.puts(Floor.process(String.graphemes(File.read!("input.txt")), 0))
