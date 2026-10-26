defmodule Acw.P0.Test do
  use ExUnit.Case
  doctest Acw.P0

  test "sample input gives correct answer" do
    assert Acw.P0.answer("test.txt") == 12
  end
end
