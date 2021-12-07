defmodule Day7 do
  def solve_1(raw_input \\ nil) do
    positions =
      raw_input
      |> get_input()
      |> parse_input()

    {min_position, max_position} = {0, Enum.max(positions)}

    Enum.map(
      min_position..max_position,
      fn number ->
        positions
        |> Enum.map(fn
          position -> abs(number - position)
        end)
        |> Enum.sum()
      end
    )
    |> Enum.min()
  end

  def solve_2(raw_input \\ nil) do
    positions =
      raw_input
      |> get_input()
      |> parse_input()

    {min_position, max_position} = {0, Enum.max(positions)}

    Enum.map(
      min_position..max_position,
      fn test_position ->
        positions
        |> Enum.map(fn
          position -> 0..abs(test_position - position) |> Enum.sum()
        end)
        |> Enum.sum()
      end
    )
    |> Enum.min()
  end

  defp get_input(nil), do: Api.get_input(7)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.replace_suffix("\n", "")
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
