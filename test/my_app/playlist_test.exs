defmodule MyApp.PlaylistTest do
  use MyApp.DataCase, async: false

  alias MyApp.Playlist

  describe "artist/1" do
    test "returns the songs by artist" do
      result = Playlist.artist("The Kooks")

      assert result[:name] == "This is The Kooks"
      assert Enum.any?(result[:songs], fn song -> song["artist"] == "The Kooks" end)
    end
  end
end
