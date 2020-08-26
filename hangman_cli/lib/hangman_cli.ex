defmodule HangmanCli do
  defdelegate start(), to: HangmanCli.Interact
end
