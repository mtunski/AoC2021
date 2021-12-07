defmodule Day6Test do
  use ExUnit.Case
  doctest Day6
  alias Day6

  @test_input "3,4,3,1,2"

  test "Part 1" do
    assert Day6.solve_1(@test_input) == 5934
  end

  test "Part 2" do
    assert Day6.solve_2(@test_input) == 26_984_457_539
  end
end
