defmodule ExMonobank.CurrencyInfo do
  @enforce_keys [:currency_code_a, :currency_code_b, :date]
  defstruct [:currency_code_a, :currency_code_b, :date, :rate_sell, :rate_buy, :rate_cross]
end
