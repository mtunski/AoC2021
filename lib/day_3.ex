defmodule Day3 do
  def solve_1(raw_input \\ nil) do
    bits =
      get_input(raw_input)
      |> Enum.map(fn bitstring ->
        bitstring
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.zip()
      |> Enum.map(fn bittup ->
        bittup
        |> Tuple.to_list()
        |> Enum.group_by(& &1)
        |> Enum.map(fn {k, v} -> {k, length(v)} end)
      end)
      |> Enum.map(fn tuples ->
        gamma_bit = Enum.max_by(tuples, &elem(&1, 1)) |> elem(0)
        epsilon_bit = if gamma_bit == 0, do: 1, else: 0

        %{
          gamma_bit: gamma_bit,
          epsilon_bit: epsilon_bit
        }
      end)

    gamma = bits |> Enum.map(& &1.gamma_bit) |> Enum.join() |> String.to_integer(2)
    epsilon = bits |> Enum.map(& &1.epsilon_bit) |> Enum.join() |> String.to_integer(2)

    gamma * epsilon
  end

  def solve_2(raw_input \\ nil) do
    bits_matrix =
      get_input(raw_input)
      |> Enum.map(fn bitstring ->
        bitstring
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    runs =
      (bits_matrix
       |> Enum.at(0)
       |> length) - 1

    oxygen_generator_rating = calculate_rating(runs, bits_matrix, :oxygen_generator)
    co_scrubber_rating = calculate_rating(runs, bits_matrix, :co_scrubber)

    oxygen_generator_rating * co_scrubber_rating
  end

  defp calculate_rating(runs, bits_matrix, rating) do
    0..runs
    |> Enum.reduce(bits_matrix, fn index, bits ->
      needed_bit =
        bits
        |> Enum.zip()
        |> Enum.map(&Tuple.to_list/1)
        |> Enum.at(index)
        |> Enum.group_by(& &1)
        |> Enum.map(fn {k, v} -> {k, length(v)} end)
        |> Enum.max_by(&elem(&1, 1), fn el1, el2 ->
          case rating do
            :oxygen_generator -> el1 > el2
            _ -> el1 <= el2
          end
        end)
        |> elem(0)

      bits |> Enum.filter(&(&1 |> Enum.at(index) == needed_bit))
    end)
    |> Enum.at(0)
    |> Enum.join()
    |> String.to_integer(2)
  end

  defp get_input(nil), do: Api.get_input(3) |> parse_input()
  defp get_input(raw_input), do: parse_input(raw_input)

  defp parse_input(input),
    do:
      input
      |> String.split("\n")
      |> Enum.filter(&(String.length(&1) > 0))
end
