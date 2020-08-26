defmodule HangmanCli.Interact do
  @hangman_server :"hangman@Santiagos-MacBook-Pro"

  alias HangmanCli.{State, Player}

  def start() do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  defp new_game() do
    Node.connect(@hangman_server)
    :rpc.call(@hangman_server, Hangman, :new_game, [])
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end
end
