defmodule MyApp.Lastfm.ClientTest do
  use MyApp.DataCase, async: false

  alias MyApp.Lastfm.Client

  setup do
    bypass = Bypass.open()

    {:ok, bypass: bypass}
  end

  describe "search/2" do
    test "searches tracks by the term", %{bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(conn, 200, payload())
      end)

      response = Client.search("The Kooks", endpoint_url(bypass.port))

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
