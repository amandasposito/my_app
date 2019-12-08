defmodule MyApp.Lastfm.ClientTest do
  use MyApp.DataCase, async: false

  alias MyApp.Lastfm.Client

  describe "search/2" do
    test "searches tracks by the term" do
      response = Client.search("The Kooks")

      assert {:ok,
              [
                %{
                   "artist" => "The Kooks",
                   "name" => "Seaside",
                   "url" => "https://www.last.fm/music/The+Kooks/_/Seaside"
                 }
              ]} = response
    end
  end
end
