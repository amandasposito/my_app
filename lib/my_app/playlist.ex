defmodule MyApp.Playlist do
  alias MyApp.Lastfm.Client

  def artist(name) do
    {:ok, songs} = Client.search(name)

    %{
      name: "This is #{name}",
      songs: songs
    }
  end
end
