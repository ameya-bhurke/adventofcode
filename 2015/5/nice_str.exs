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

  def same_consecutive(str, i) do
    String.graphemes(str)
    |> Enum.chunk_every(i+1, 1, :discard)
    |> Enum.reduce(false, fn x, acc -> acc || Enum.at(x, 0) == Enum.at(x, i) end)
  end

  def does_not_contain(str) do
    line_up = ["ab", "cd", "pq", "xy"]

    String.graphemes(str)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn x -> Enum.join(x) end)
    |> Enum.reduce(true, fn x, acc -> acc && !Enum.member?(line_up, x) end)
  end

  def find_indexes(collection, function) do
    Enum.filter_map(Enum.with_index(collection), fn({x, _y}) -> function.(x) end, &elem(&1, 1))
  end

  def pairs(str) do
    str
    |> String.graphemes
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn x -> Enum.join(x) end)
  end

  def pairs_with_diff_indexes(str, x) do
    list = find_indexes(pairs(str), fn(y) -> y == x end)
    length(list) > 1 && (Enum.at(list, 1) - Enum.at(list, 0)) > 1
  end

  def find_repeating_pairs(str) do
    pairs(str)
    |> Enum.reduce(false, fn x, acc -> acc || pairs_with_diff_indexes(str, x) end) 
  end

  def check(str) do
    contains_3_vowels(str)
    && same_consecutive(str, 1)
    && does_not_contain(str)
  end

  def check2(str) do
    same_consecutive(str, 2)
    && find_repeating_pairs(str)
  end

end

File.read!("string.txt")
|> String.split("\n", trim: true)
|> Enum.reduce(0, fn x, acc -> acc + case NiceStr.check2(x) do
        true -> 1
	false -> 0
      end
    end)
|> IO.puts    
