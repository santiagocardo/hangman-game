defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import GallowsWeb.Helpers.GameStateHelper

  def game_over?(game_state) do
    game_state in [:won, :lost]
  end

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  def join_letters(list) do
    list |> Enum.join(" ")
  end

  def turn(left, target) when target >= left do
    "opacity: 1"
  end

  def turn(_left, _target) do
    "opacity: 0.1"
  end
end
