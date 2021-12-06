defmodule Day5 do
  def solve_1(raw_input \\ nil) do
    raw_input
    |> get_input()
    |> parse_input()
    |> Enum.filter(fn coordinates_set ->
      [{x1, y1}, {x2, y2}] = coordinates_set
      x1 == x2 || y1 == y2
    end)
    |> Enum.flat_map(fn coordinates_set ->
      [{x1, y1}, {x2, y2}] = coordinates_set

      case x1 == x2 do
        true -> y1..y2 |> Enum.map(&{x1, &1})
        _ -> x1..x2 |> Enum.map(&{&1, y1})
      end
    end)
    |> Enum.frequencies()
    |> Enum.count(fn {_, frequency} -> frequency >= 2 end)
  end

  def solve_2(raw_input \\ nil) do
    raw_input
    |> get_input()
    |> parse_input()
    |> Enum.flat_map(fn coordinates_set ->
      [{x1, y1}, {x2, y2}] = coordinates_set

      case {x1 == x2, y1 == y2} do
        {true, false} -> y1..y2 |> Enum.map(&{x1, &1})
        {false, true} -> x1..x2 |> Enum.map(&{&1, y1})
        _ -> Enum.zip(x1..x2, y1..y2)
      end
    end)
    |> Enum.frequencies()
    |> Enum.count(fn {_, frequency} -> frequency >= 2 end)
  end

  defp get_input(nil), do: Api.get_input(5)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" -> ")
      |> Enum.map(fn coords ->
        coords |> String.split(",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      end)
    end)
  end
end
