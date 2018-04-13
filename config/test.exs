use Mix.Config

config :rabid_racoon,
	espnUrl: "http://games.espn.com/flb/scoreboard?leagueId=1080&seasonId=2018"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rabid_racoon, RabidRacoonWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
