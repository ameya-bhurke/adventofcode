defmodule Floor do
  def score("("), do: 1
  def score(")"), do: -1
  def score(_), do: 0

  def process([], total), do: total
  def process([head | tail], total), do: process(tail, score(head) + total)

  def process_2([_ | _], {total, count}) when total == -1, do: count

  def process_2([head | tail], {total, count}), do: process_2(tail, {score(head) + total, count + 1})

end

IO.puts(Floor.process(String.graphemes(File.read!("input.txt")), 0))
IO.puts(Floor.process_2(String.graphemes(File.read!("input.txt")), {0, 0}))
