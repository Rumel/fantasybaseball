defmodule RabidRacoonWeb.PageController do
  use RabidRacoonWeb, :controller

  def index(conn, _params) do
    %{body: body} = HTTPoison.get! "http://games.espn.com/fhl/scoreboard?leagueId=13103&scoringPeriodId=181"

    results = body
    |> Floki.find(".team")
    |> Enum.map(fn team ->
        %{
          name: team |> Floki.find(".name a") |> Floki.text,
          teamLink: team|> Floki.find(".name a") |> Floki.attribute("href") |> List.first
        }
    end)

    matchups = body
    |> Floki.find(".matchup .boxscoreLinks a:nth-child(2)") 
    |> Enum.map(fn x -> x 
      |> Floki.attribute("href") 
      |> List.first 
    end)

    matchupLinks = Enum.zip(matchups, matchups) 
    |> Enum.map(fn x -> Tuple.to_list(x) end) 
    |> List.flatten 
    |> Enum.map(fn x -> 
      %{
        matchupLink: x
      }
    end)

    scores = body
    |> Floki.find(".score")
    |> Enum.map(fn elem -> 
        %{ 
          score: elem |> Floki.text |> String.to_float
        }
    end)

    nums = 1..(length(scores)) |> Enum.map(fn x -> %{ place: x } end)

    maps = map_merge(results, scores)
    |> map_merge(matchupLinks)
    |> Enum.sort_by(fn x -> x.score end)
    |> Enum.reverse
    |> map_merge(nums)

    IO.inspect maps

    render conn, "index.html", %{ teams: maps }
  end

  defp map_merge(map_a, map_b) do
    Enum.zip(map_a, map_b) |> Enum.map(fn {x, y} -> Map.merge(x, y) end)
  end
end
