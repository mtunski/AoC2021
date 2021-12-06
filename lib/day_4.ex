defmodule Day4 do
  def solve_1(raw_input \\ nil) do
    [numbers | boards] = raw_input |> get_input() |> parse_input()

    {winning_number, winning_board} =
      Enum.reduce_while(numbers, boards, fn number, boards ->
        case Enum.reduce_while(boards, [], fn board, marked_boards ->
               marked_board = mark_number(board, number)

               case check_board(marked_board) do
                 true -> {:halt, {number, marked_board}}
                 _ -> {:cont, marked_boards ++ [marked_board]}
               end
             end) do
          result when is_tuple(result) -> {:halt, result}
          marked_boards -> {:cont, marked_boards}
        end
      end)

    unmarked_numbers_sum =
      winning_board |> List.flatten() |> Enum.filter(&is_number/1) |> Enum.sum()

    winning_number * unmarked_numbers_sum
  end

  defp mark_number(board, number) do
    Enum.map(board, fn row ->
      Enum.map(row, fn item ->
        case item == number do
          true -> %{marked: true, number: number}
          _ -> item
        end
      end)
    end)
  end

  defp check_board(board) do
    rows_and_cols = board ++ Enum.zip_with(board, & &1)

    Enum.any?(rows_and_cols, fn row ->
      row
      |> Enum.all?(fn number ->
        case number do
          n when is_number(n) -> false
          _ -> number.marked
        end
      end)
    end)
  end

  def solve_2(raw_input \\ nil) do
    [numbers | boards] = raw_input |> get_input() |> parse_input()

    {last_winning_number, last_winning_board} =
      Enum.reduce_while(numbers, boards, fn number, boards ->
        {marked_boards, last_board} =
          Enum.reduce(boards, {[], nil}, fn board, {marked_boards, _} ->
            marked_board = mark_number(board, number)

            case check_board(marked_board) do
              true -> {marked_boards, marked_board}
              _ -> {marked_boards ++ [marked_board], nil}
            end
          end)

        case length(marked_boards) == 0 do
          true -> {:halt, {number, last_board}}
          _ -> {:cont, marked_boards}
        end
      end)

    unmarked_numbers_sum =
      last_winning_board |> List.flatten() |> Enum.filter(&is_number/1) |> Enum.sum()

    last_winning_number * unmarked_numbers_sum
  end

  defp get_input(nil), do: Api.get_input(4)
  defp get_input(raw_input), do: raw_input

  defp parse_input(input) do
    [numbers | boards] =
      input
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, "\n", trim: true))

    numbers = Enum.at(numbers, 0) |> String.split(",") |> Enum.map(&String.to_integer/1)

    boards =
      Enum.map(boards, fn board ->
        Enum.map(board, fn row ->
          row |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
        end)
      end)

    [numbers | boards]
  end
end
