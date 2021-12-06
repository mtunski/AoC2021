defmodule Day1 do
  def solve_1(raw_input \\ nil) do
    raw_input
    |> get_input()
    |> parse_input
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [prev, next] -> next > prev end)
  end

  def solve_2(raw_input \\ nil) do
    raw_input
    |> get_input()
    |> parse_input
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [prev, next] -> Enum.sum(next) > Enum.sum(prev) end)
  end

  defp get_input(nil), do: Api.get_input(1)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&String.to_integer/1)
  end
end
