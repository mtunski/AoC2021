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

  def solve_2(raw_input \\ nil) do
    input =
      raw_input
      |> get_input()
      |> parse_input()

    values =
      input
      |> Enum.join()
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)

    row_length = input |> Enum.at(0) |> String.length()

    {mapping, _} =
      values
      |> Enum.with_index()
      |> Enum.reduce({%{}, 1}, fn {_value, index}, {mapping, next_basin_index} ->
        left_index = if rem(index, row_length) > 0, do: index - 1, else: nil
        top_index = if index - row_length >= 0, do: index - row_length, else: nil
        right_index = if 1 + rem(index, row_length) < row_length, do: index + 1, else: nil
        bottom_index = index + row_length

        current = Enum.at(values, index)

        right = if right_index, do: Enum.at(values, right_index), else: nil
        bottom = Enum.at(values, bottom_index)

        case current do
          9 ->
            IO.inspect({index, next_basin_index})
            next_basin_index = if right < 9, do: next_basin_index + 1, else: next_basin_index

            {mapping, next_basin_index}

          _ ->
            current_basin_index =
              mapping[index] || mapping[left_index] || mapping[top_index] || mapping[right_index] ||
                mapping[bottom_index] || next_basin_index

            new_mapping = Map.put(mapping, index, current_basin_index)

            new_mapping =
              if right < 9 && mapping[right_index] == nil,
                do: Map.put(new_mapping, right_index, current_basin_index),
                else: new_mapping

            new_mapping =
              if bottom < 9 && mapping[bottom_index] == nil,
                do: Map.put(new_mapping, bottom_index, current_basin_index),
                else: new_mapping

            {new_mapping, next_basin_index}
        end
      end)

    mapping
    |> Enum.group_by(fn {_, v} -> v end)
    |> Enum.map(fn {_, v} -> length(v) end)
    |> Enum.sort(&>=/2)
    |> Enum.take(3)
    |> Enum.reduce(1, fn val, acc -> val * acc end)
  end

  defp get_input(nil), do: Api.get_input(9)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.replace_suffix("\n", "")
    |> String.split("\n", trim: true)
  end
end
