defmodule Area do
  def sides(l, w, h), do: {l*w, w*h, h*l}

  def least(areas) do 
    areas
    |> Tuple.to_list
    |> Enum.min
  end

  def least2(areas) do
    areas
    |> Tuple.to_list
    |> Enum.sort
    |> Enum.take(2)
  end

  def ribbon(areas) do
    areas
    |> least2
    |> Enum.map(fn x -> x * 2 end)
    |> Enum.sum
  end

  def ribbon_bow(areas) do 
    ribbon(areas) + ( areas 
      |> Tuple.to_list
      |> Enum.product )
  end

  def paper(l, w, h) do
    ( sides(l, w, h)
      |> least ) + 
    ( 2 * ( sides(l, w, h)
      |> Tuple.to_list
      |> Enum.sum )
    )
  end

  def total(l, w, h) do 
    {
      paper(l,w,h),
      ribbon_bow({l, w, h})
    }
  end
end

totals = File.stream!("input")
|> Stream.map( &String.replace(&1, "\n", "") )
|> Stream.map( &String.split(&1, "x") )
|> Stream.map( &Area.total(String.to_integer(Enum.at(&1,0)), String.to_integer(Enum.at(&1, 1)), String.to_integer(Enum.at(&1, 2)) ) )
|> Enum.to_list()

totals
|> Enum.map(fn {paper, _} -> paper end)
|> Enum.sum
|> IO.puts


totals
|> Enum.map(fn {_, ribbon} -> ribbon end)
|> Enum.sum
|> IO.puts
