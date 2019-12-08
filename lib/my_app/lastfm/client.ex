defmodule MyApp.Lastfm.Client do
  @moduledoc"""
  Search tracks

  https://www.last.fm/api/show/track.search
  """

  @api_url "https://ws.audioscrobbler.com/2.0/"

  def search(term, url \\ @api_url) do
    response = Mojito.request(method: :get, url: search_url(url, term))

    case response do
      {:ok, %{status_code: 200, body: body}} ->
        {:ok, response(body)}
      {:ok, %{status_code: 404}} ->
        {:not_found, "Not found"}
      {_, response} ->
        {:error, response}
    end
  end

  defp response(body) do
    body
    |> Jason.decode!()
    |> Map.fetch!("results")
    |> Map.fetch!("trackmatches")
    |> Map.fetch!("track")
    |> Enum.map(fn result ->
      %{
        "artist" => result["artist"],
        "name" => result["name"],
        "url" => result["url"]
      }
    end)
  end

  defp search_url(url, term) do
    URI.encode("#{url}?method=track.search&track=#{term}&api_key=#{System.get_env("LASTFM_API_KEY")}&format=json")
  end
end
