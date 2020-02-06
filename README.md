# ExMonobank

Unofficial Elixir wrapper for Monobank API

## Functions
### PublicAPI
#### bank_currency()
Example:

```elixir
ExMonobank.PublicAPI.bank_currency()

{:ok,
 [
   %ExMonobank.CurrencyInfo{
     currency_code_a: 840,
     currency_code_b: 980,
     date: ~U[2020-01-30 11:40:09Z],
     rate_buy: 24.761,
     rate_cross: nil,
     rate_sell: 25.0514
   },
   %ExMonobank.CurrencyInfo{
     currency_code_a: 978,
     currency_code_b: 980,
     date: ~U[2020-01-30 13:00:05Z],
     rate_buy: 27.161,
     rate_cross: nil,
     rate_sell: 27.6098
   },
   %ExMonobank.CurrencyInfo{
     currency_code_a: 643,
     currency_code_b: 980,
     date: ~U[2020-01-30 11:40:09Z],
     rate_buy: 0.363,
     rate_cross: nil,
     rate_sell: 0.398
   },
   # ...
 ]
}
```

### PersonalAPI

#### client_info()
Example:

```elixir
ExMonobank.PersonalAPI.client_info()
```

#### statement(from)
Example:

```elixir
{:ok, from_date, 0} = DateTime.from_iso8601("2020-01-06T23:50:07Z")
ExMonobank.PersonalAPI.statement(from_date)
```

#### statement(account, from)

#### statement(account, from, to)

#### webhook(url)

## Installation

The package can be installed by adding `ex_monobank` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_monobank, "~> 1.0.0"}
  ]
end
```
