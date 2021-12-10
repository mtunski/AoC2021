defmodule Day9Test do
  use ExUnit.Case
  doctest Day9
  alias Day9

  @test_input """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  test "Part 1" do
    assert Day9.solve_1(@test_input) == 15
  end

  # test "Part 2" do
  #   assert Day9.solve_2(@test_input) == 61229
  # end
end
