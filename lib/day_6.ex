defmodule Day6 do
  def solve_1(raw_input \\ nil) do
    initial_state =
      raw_input
      |> get_input()
      |> parse_input()

    1..80
    |> Enum.reduce(initial_state, fn _, state ->
      new_guys_count = Enum.count(state, &(&1 == 0))
      new_guys = for(i <- 0..new_guys_count, i > 0, do: 8)

      new_state =
        state
        |> Enum.map(fn counter ->
          case counter == 0 do
            true -> 6
            _ -> counter - 1
          end
        end)

      new_state ++ new_guys
    end)
    |> length()
  end

  def solve_2(raw_input \\ nil) do
    initial_state =
      raw_input
      |> get_input()
      |> parse_input()
      |> Enum.frequencies()

    1..256
    |> Enum.reduce(initial_state, fn _day, state ->
      Enum.reduce(state, %{}, fn {timer, count}, current_state ->
        case timer do
          0 ->
            current_state
            |> Map.update(8, count, fn current_count -> current_count + 1 end)
            |> Map.update(6, count, fn current_count -> current_count + 1 end)

          _ ->
            Map.update(current_state, timer - 1, count, fn current_count ->
              current_count + count
            end)
        end
      end)
    end)
    |> Enum.map(fn {_timer, count} -> count end)
    |> Enum.sum()
  end

  defp get_input(nil), do: Api.get_input(6)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.replace_suffix("\n", "")
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
