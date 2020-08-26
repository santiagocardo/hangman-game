defmodule HangmanCli.Prompter do
  alias HangmanCli.State

  def accept_move(game = %State{}) do
    IO.gets("Your guess: ")
    |> check_input(game)
  end

  defp check_input({:error, reason}, _) do
    IO.puts("Game ended: #{reason}")
    exit(:normal)
  end

  defp check_input(:eof, _) do
    IO.puts("Looks like you gave up...")
    exit(:normal)
  end

  defp check_input(input, game) do
    guess = String.trim(input)

    cond do
      guess =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, guess)

      true ->
        IO.puts("Please enter a single lower case letter")
        accept_move(game)
    end
  end
end
