defmodule Acw.P1.Test do
  use ExUnit.Case
  doctest Acw.P1

  test "sample input gives correct answer" do
    assert Acw.P1.answer("test.txt") == 30
  end
end
