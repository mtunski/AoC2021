defmodule Day7Test do
  use ExUnit.Case
  doctest Day7
  alias Day7

  @test_input "16,1,2,0,4,2,7,1,2,14"

  test "Part 1" do
    assert Day7.solve_1(@test_input) == 37
  end

  test "Part 2" do
    assert Day7.solve_2(@test_input) == 168
  end
end
