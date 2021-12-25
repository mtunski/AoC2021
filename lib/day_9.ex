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

    side_len = input |> Enum.at(0) |> String.length()

    map =
      [
        input
        |> Enum.join()
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.with_index()
      ]
      |> Enum.zip_with(fn [{v, i}] ->
        row = Integer.floor_div(i, side_len)
        col = rem(i, side_len)
        {{row, col}, v}
      end)
      |> Enum.into(%{})

    {map_with_basins, _} =
      map
      |> Enum.reduce({map, 1}, fn {{row, col}, _}, {map_with_basins, basin_id} ->
        {fill_basin(map_with_basins, {row, col}, basin_id), basin_id + 1}
      end)

    map_with_basins
    |> Enum.filter(fn {_, basin_id} -> is_binary(basin_id) end)
    |> Enum.frequencies_by(fn {_, basin_id} -> basin_id end)
    |> Enum.sort_by(fn {_, cell_count} -> cell_count end, &>=/2)
    |> Enum.take(3)
    |> Enum.reduce(1, fn {_, cell_count}, product ->
      cell_count * product
    end)
  end

  defp fill_basin(map, {row, col}, basin_id) do
    value = map[{row, col}]

    case value < 9 do
      true ->
        map
        |> Map.put({row, col}, "b#{basin_id}")
        |> fill_basin({row, col - 1}, basin_id)
        |> fill_basin({row, col + 1}, basin_id)
        |> fill_basin({row - 1, col}, basin_id)
        |> fill_basin({row + 1, col}, basin_id)

      false ->
        map
    end
  end

  defp get_input(nil), do: Api.get_input(9)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    input
    |> String.replace_suffix("\n", "")
    |> String.split("\n", trim: true)
  end
end
