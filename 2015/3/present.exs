defmodule Presents do
  def next_location({x, y}, "^"), do: {x, y + 1} 
  def next_location({x, y}, "<"), do: {x - 1, y} 
  def next_location({x, y}, ">"), do: {x + 1, y} 
  def next_location({x, y}, "v"), do: {x, y - 1} 
  def next_location({x, y}, _), do: {x, y} 

  def process([], loc_set, _loc), do: loc_set
  def process([head | tail], loc_set, loc), do: process(tail, MapSet.put(loc_set, next_location(loc, head)), next_location(loc, head))
  
  def process_robo(["\n"], loc_set, _loc), do: loc_set
  def process_robo([_ | [head | tail]], loc_set, loc), do: process_robo(tail, MapSet.put(loc_set, next_location(loc, head)), next_location(loc, head))

  def process_santa(["\n"], loc_set, _loc), do: loc_set
  def process_santa([head | [_|tail]], loc_set, loc), do: process_santa(tail, MapSet.put(loc_set, next_location(loc, head)), next_location(loc, head))
end

Presents.process(String.graphemes(File.read!("input")), MapSet.new(), {0, 0})
|> MapSet.size
|> IO.puts

((MapSet.union(Presents.process_robo(String.graphemes(File.read!("input")), MapSet.new(), {0, 0}), 
  Presents.process_santa(String.graphemes(File.read!("input")), MapSet.new(), {0, 0})))
  |> MapSet.size)
  |> IO.puts
