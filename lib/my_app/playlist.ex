defmodule MyApp.Playlist do
  @music Application.get_env(:my_app, :music)

  def artist(name) do
    {:ok, songs} = @music.search(name)

    %{
      "name" => "This is #{name}",
      "songs" => songs
    }
  end
end
