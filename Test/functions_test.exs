defmodule FunctionsTest do
  use ExUnit.Case
  doctest Functions
  doctest Functions.Recursive

  test "greets the world" do
    assert Functions.hello() == :world
  end

  test "queens" do
    assert Functions.Recursive.queens(8) |> length == 92
    assert Functions.Recursive.queens(9) |> length == 352
    assert Functions.Recursive.queens(10) |> length == 724
  end
end
