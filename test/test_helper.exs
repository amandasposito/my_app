ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, :manual)

Application.ensure_all_started(:bypass)
