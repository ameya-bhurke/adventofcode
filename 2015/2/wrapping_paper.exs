defmodule Area do
  def sides(l, w, h), do: {l*w, w*h, h*l}

  def least(areas) do 
    areas
    |> Tuple.to_list
    |> Enum.min
  end

  def area(l, w, h) do
    min = sides(l, w, h)
    |> least
    
    total = sides(l, w, h)
    |> Tuple.to_list
    |> Enum.sum

    total * 2 + min
  end
end

File.stream!("input")
|> Stream.map( &String.replace(&1, "\n", "") )
|> Stream.map( &String.split(&1, "x") )
|> Stream.map( &Area.area(String.to_integer(Enum.at(&1,0)), String.to_integer(Enum.at(&1, 1)), String.to_integer(Enum.at(&1, 2)) ) )
|> Enum.to_list()
|> Enum.sum
|> IO.puts
