defmodule Day8 do
  def solve_1(raw_input \\ nil) do
    raw_input
    |> get_input()
    |> parse_input()
    |> Enum.flat_map(fn s ->
      [_patterns, output] = String.split(s, " | ")
      output |> String.split(" ")
    end)
    |> Enum.frequencies_by(&String.length/1)
    |> Map.take([2, 3, 4, 7])
    |> Map.values()
    |> Enum.sum()
  end

  defp get_input(nil), do: Api.get_input(8)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.replace_suffix("\n", "")
    |> String.split("\n", trim: true)
  end
end
