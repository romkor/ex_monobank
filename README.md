# ExMonobank

Unofficial Elixir wrapper for Monobank API

## Functions

### ExMonobank.bank_currency()
Example response:

```elixir
{:ok,
 [
   %{
     "currencyCodeA" => 840,
     "currencyCodeB" => 980,
     "date" => ~U[2020-01-30 11:40:09Z],
     "rateBuy" => 24.761,
     "rateSell" => 25.0514
   },
   %{
     "currencyCodeA" => 978,
     "currencyCodeB" => 980,
     "date" => ~U[2020-01-30 13:00:05Z],
     "rateBuy" => 27.161,
     "rateSell" => 27.6098
   },
   %{
     "currencyCodeA" => 643,
     "currencyCodeB" => 980,
     "date" => ~U[2020-01-30 11:40:09Z],
     "rateBuy" => 0.363,
     "rateSell" => 0.398
   },
   # ...
 ]
}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_monobank` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_monobank, "~> 0.1.0"}
  ]
end
```
