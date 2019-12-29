defmodule MyApp.PlaylistTest do
  use MyApp.DataCase, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  alias MyApp.{MusicMock, Playlist}

  describe "artist/1" do
    test "returns the songs by artist" do
      MusicMock
      |> expect(:search, fn _name ->
        {
          :ok,
          [
            %{
              "artist" => "The Kooks",
              "name" => "Seaside",
              "url" => "https://www.last.fm/music/The+Kooks/_/Seaside"
            }
          ]
        }
      end)

      result = Playlist.artist("The Kooks")

      assert result["name"] == "This is The Kooks"

      assert Enum.any?(result["songs"], fn song ->
               song["artist"] == "The Kooks"
             end)
    end
  end
end
