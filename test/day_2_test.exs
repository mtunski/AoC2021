defmodule Day2Test do
  use ExUnit.Case
  doctest Day2
  alias Day2

  @test_input """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  # forward 5 adds 5 to your horizontal position, a total of 5.
  # down 5 adds 5 to your depth, resulting in a value of 5.
  # forward 8 adds 8 to your horizontal position, a total of 13.
  # up 3 decreases your depth by 3, resulting in a value of 2.
  # down 8 adds 8 to your depth, resulting in a value of 10.
  # forward 2 adds 2 to your horizontal position, a total of 15.

  # After following these instructions, you would have a horizontal position of 15 and a depth of 10. (Multiplying these together produces 150.)
  test "Part 1" do
    assert Day2.solve_1(@test_input) == 150
  end

  # forward 5 adds 5 to your horizontal position, a total of 5. Because your aim is 0, your depth does not change.
  # down 5 adds 5 to your aim, resulting in a value of 5.
  # forward 8 adds 8 to your horizontal position, a total of 13. Because your aim is 5, your depth increases by 8*5=40.
  # up 3 decreases your aim by 3, resulting in a value of 2.
  # down 8 adds 8 to your aim, resulting in a value of 10.
  # forward 2 adds 2 to your horizontal position, a total of 15. Because your aim is 10, your depth increases by 2*10=20 to a total of 60.

  # After following these new instructions, you would have a horizontal position of 15 and a depth of 60. (Multiplying these produces 900.)
  test "Part 2" do
    assert Day2.solve_2(@test_input) == 900
  end
end
