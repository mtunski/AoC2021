defmodule Day2 do
  def solve_1(raw_input \\ nil) do
    map =
      get_input(raw_input)
      |> Enum.reduce(%{"forward" => 0, "down" => 0, "up" => 0}, fn string, map ->
        [direction, value] = String.split(string, " ")
        value = String.to_integer(value)
        Map.update!(map, direction, fn stored_value -> stored_value + value end)
      end)

    map["forward"] * (map["down"] - map["up"])
  end

  def solve_2(raw_input \\ nil) do
    map =
      get_input(raw_input)
      |> Enum.reduce(%{"horizontal_position" => 0, "depth" => 0, "aim" => 0}, fn string, map ->
        [direction, value] = String.split(string, " ")
        value = String.to_integer(value)

        Map.merge(
          map,
          case direction do
            "forward" ->
              %{
                "horizontal_position" => map["horizontal_position"] + value,
                "depth" => map["depth"] + map["aim"] * value
              }

            "up" ->
              %{"aim" => map["aim"] - value}

            "down" ->
              %{"aim" => map["aim"] + value}
          end
        )
      end)

    map["horizontal_position"] * map["depth"]
  end

  defp get_input(nil), do: Api.get_input(2) |> parse_input()
  defp get_input(raw_input), do: parse_input(raw_input)

  defp parse_input(input),
    do:
      input
      |> String.split("\n")
      |> Enum.filter(&(String.length(&1) > 0))
end
