defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert List.to_string(game.letters) =~ ~r/^[a-z0-9_\-]+$/
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _tally} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is not already used" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is reconized" do
    game = Game.new_game("magic")

    {game, _tally} = Game.make_move(game, "g")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "have won the game" do
    game = Game.new_game("magic")

    {game, _tally} = Game.make_move(game, "m")
    assert game.game_state == :good_guess
    {game, _tally} = Game.make_move(game, "a")
    assert game.game_state == :good_guess
    {game, _tally} = Game.make_move(game, "g")
    assert game.game_state == :good_guess
    {game, _tally} = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    {game, _tally} = Game.make_move(game, "c")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game("magic")

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "have lost the game" do
    game = Game.new_game("magic")

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5
    {game, _tally} = Game.make_move(game, "z")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4
    {game, _tally} = Game.make_move(game, "j")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3
    {game, _tally} = Game.make_move(game, "k")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2
    {game, _tally} = Game.make_move(game, "l")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1
    {game, _tally} = Game.make_move(game, "n")
    assert game.game_state == :lost
  end

  test "have won the game - iteration version" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    init_game = Game.new_game("wibble")

    Enum.reduce(moves, init_game, fn {guess, state}, game ->
      {game, _tally} = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end)
  end
end
