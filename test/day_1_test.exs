defmodule Day1Test do
  use ExUnit.Case
  doctest Day1
  alias Day1

  @test_input """
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
  """

  test "Part 1" do
    assert Day1.solve_1(@test_input) == 7
  end

  test "Part 2" do
    assert Day1.solve_2(@test_input) == 5
  end
end
