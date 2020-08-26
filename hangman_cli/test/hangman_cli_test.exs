defmodule HangmanCliTest do
  use ExUnit.Case
  doctest HangmanCli

  test "greets the world" do
    assert HangmanCli.hello() == :world
  end
end
