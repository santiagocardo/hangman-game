defmodule HangmanCli.Summary do
  def display(game = %{tally: tally}) do
    IO.puts([
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Guessed left: #{tally.turns_left}\n",
      "Used letters: #{Enum.join(tally.used, " ")}\n"
    ])

    game
  end
end
