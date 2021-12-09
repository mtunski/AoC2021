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

  def solve_2(raw_input \\ nil) do
    raw_input
    |> get_input()
    |> parse_input()
    |> Enum.map(fn s ->
      [patterns, output] = String.split(s, " | ")

      mapping =
        patterns
        |> String.split(" ", trim: true)
        |> Enum.map(&(&1 |> String.split("", trim: true) |> Enum.sort() |> Enum.join()))
        |> Enum.sort_by(&String.length/1)
        |> Enum.reduce(%{}, fn string, mapping ->
          cond do
            is_eight(string) -> Map.put(mapping, 8, string)
            is_four(string) -> Map.put(mapping, 4, string)
            is_seven(string) -> Map.put(mapping, 7, string)
            is_one(string) -> Map.put(mapping, 1, string)
            is_zero(string, mapping) -> Map.put(mapping, 0, string)
            is_six(string, mapping) -> Map.put(mapping, 6, string)
            is_nine(string, mapping) -> Map.put(mapping, 9, string)
            is_three(string, mapping) -> Map.put(mapping, 3, string)
            is_five(string, mapping) -> Map.put(mapping, 5, string)
            is_two(string, mapping) -> Map.put(mapping, 2, string)
            true -> mapping
          end
        end)

      output
      |> String.split(" ", trim: true)
      |> Enum.map(&(&1 |> String.split("", trim: true) |> Enum.sort() |> Enum.join()))
      |> Enum.map(fn signal ->
        {value, _} = Enum.find(mapping, fn {_, pattern} -> signal == pattern end)
        value
      end)
      |> Enum.join("")
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  defp is_one(string), do: String.length(string) == 2
  defp is_seven(string), do: String.length(string) == 3
  defp is_four(string), do: String.length(string) == 4
  defp is_eight(string), do: String.length(string) == 7

  defp is_five(string, mapping) do
    String.length(string) == 5 &&
      !is_three(string, mapping) &&
      (String.split(mapping[4], "") -- String.split(string, "")) |> length() == 1
  end

  defp is_three(string, mapping),
    do:
      String.length(string) == 5 &&
        (String.split(mapping[1], "") -- String.split(string, "")) |> length() == 0

  defp is_two(string, mapping),
    do:
      String.length(string) == 5 &&
        !is_three(string, mapping) && !is_five(string, mapping)

  defp is_nine(string, mapping),
    do:
      String.length(string) == 6 &&
        (String.split(mapping[4], "") -- String.split(string, "")) |> length() == 0

  defp is_six(string, mapping),
    do:
      String.length(string) == 6 &&
        (String.split(mapping[1], "") -- String.split(string, "")) |> length() == 1

  defp is_zero(string, mapping),
    do: String.length(string) == 6 && !is_nine(string, mapping) && !is_six(string, mapping)

  defp get_input(nil), do: Api.get_input(8)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.replace_suffix("\n", "")
    |> String.split("\n", trim: true)
  end
end
