defmodule HangmanCli.Mover do
  alias HangmanCli.State

  def make_move(game) do
    tally = Hangman.make_move(game.game_service, game.guess)

    %State{game | tally: tally}
  end
end
