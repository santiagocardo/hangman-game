defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def new_game(conn, _params) do
    render(conn, "new_game.html")
  end

  def create_game(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    conn
    |> put_session(:game, game)
    |> render("game_field.html", tally: tally)
  end

  def make_move(conn, params) do
    tally =
      params["make_move"]["guess"]
      |> do_make_move(conn)

    put_in(conn.params["make_move"]["guess"], "")
    |> render("game_field.html", tally: tally)
  end

  defp do_make_move(guess, conn) do
    conn
    |> get_session(:game)
    |> Hangman.make_move(guess)
  end
end
