defmodule NiceStr do

  def contains_3_vowels(str) do
    vowels = ["a", "e", "i", "o", "u"]

    Enum.reduce(String.graphemes(str), 0, fn c, acc ->
      acc + case Enum.member?(vowels, c) do
        true -> 1
        false -> 0
      end
    end) > 2
  end

  def same_consecutive(str) do
    String.graphemes(str)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(false, fn x, acc -> acc || Enum.at(x, 0) == Enum.at(x, 1) end)
  end

  def does_not_contain(str) do
    line_up = ["ab", "cd", "pq", "xy"]

    String.graphemes(str)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn x -> Enum.join(x) end)
    |> Enum.reduce(true, fn x, acc -> acc && !Enum.member?(line_up, x) end)
  end

  def check(str) do
    contains_3_vowels(str)
    && same_consecutive(str)
    && does_not_contain(str)
  end

end

NiceStr.check("haegwjzuvuyypxyu") |> IO.puts
File.read!("string.txt")
|> String.split("\n", trim: true)
|> Enum.reduce(0, fn x, acc -> acc + case NiceStr.check(x) do
        true -> 1
	false -> 0
      end
    end)
|> IO.puts    
