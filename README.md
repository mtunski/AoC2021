# Aoc2021

Setup:

1. Install latest Elixir
2. Login into AoC and get the session cookie. Store the value in `AOC_SESISON` environment variable.
3. `mix deps.get`

Run tests

```
mix test
```

Solve puzzle

```
mix run -e "Day1.solve_1() |> IO.inspect()"
```
