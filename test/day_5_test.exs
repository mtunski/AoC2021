defmodule Day5Test do
  use ExUnit.Case
  doctest Day5
  alias Day5

  @test_input """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  test "Part 1" do
    assert Day5.solve_1(@test_input) == 5
  end

  test "Part 2" do
    assert Day5.solve_2(@test_input) == 12
  end
end
