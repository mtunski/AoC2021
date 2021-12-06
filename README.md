# [Aoc2021](https://adventofcode.com/)

Setup:

1. Get the template `git clone -b template https://github.com/mtunski/AoC2021 && cd AoC2021`
2. Install latest Elixir
3. Login into AoC and get the session cookie. Store the value in `AOC_SESISON` environment variable.
4. `mix deps.get`

Run tests

```
mix test
```

Solve puzzle

```
mix run -e "Day1.solve_1() |> IO.inspect()"
```
