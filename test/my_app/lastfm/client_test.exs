defmodule MyApp.Lastfm.ClientTest do
  use MyApp.DataCase, async: false

  alias MyApp.Lastfm.Client

  setup do
    bypass = Bypass.open()

    original_url = Application.get_env(:my_app, :lastfm_api)

    Application.put_env(:my_app, :lastfm_api, endpoint_url(bypass.port))

    on_exit(fn ->
      Application.put_env(:my_app, :lastfm_api, original_url)
    end)

    {:ok, bypass: bypass}
  end

  describe "search/2" do
    test "searches tracks by the term", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(conn, 200, payload())
      end)

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

  defp payload do
    File.read!("./test/support/fixture/lastfm/payload.json")
  end

  defp endpoint_url(port) do
    "http://localhost:#{port}/"
  end
end
