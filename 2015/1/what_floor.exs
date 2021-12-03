defmodule Floor do
  def score("("), do: 1
  def score(")"), do: -1
  def score(_), do: 0

  def process([], count), do: count
  def process([head | tail], count), do: process(tail, score(head) + count)
end

IO.puts(Floor.process(String.graphemes(File.read!("input.txt")), 0))
