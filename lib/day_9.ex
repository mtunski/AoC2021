defmodule Day9 do
  def solve_1(raw_input \\ nil) do
    input =
      raw_input
      |> get_input()
      |> parse_input()

    row_length = input |> Enum.at(0) |> String.length()

    values =
      input
      |> Enum.join()
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)

    values
    |> Enum.with_index()
    |> Enum.reduce([], fn {v, i}, acc ->
      left = if rem(i, row_length) > 0, do: Enum.at(values, i - 1), else: nil
      top = if i - row_length >= 0, do: Enum.at(values, i - row_length), else: nil
      right = if 1 + rem(i, row_length) < row_length, do: Enum.at(values, i + 1), else: nil
      bottom = Enum.at(values, i + row_length)

      if [v, left, top, right, bottom] |> Enum.filter(&is_number/1) |> Enum.uniq() |> length > 1 and
           Enum.min([v, left, top, right, bottom]) == v,
         do: [v + 1 | acc],
         else: acc
    end)
    |> Enum.sum()
  end

  defp get_input(nil), do: Api.get_input(9)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.replace_suffix("\n", "")
    |> String.split("\n", trim: true)
  end
end
