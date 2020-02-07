defmodule ExMonobank.AccountInfo do
  @enforce_keys [:id, :balance, :cashback_type, :credit_limit, :currency_code, :masked_pan]
  defstruct [:id, :balance, :cashback_type, :credit_limit, :currency_code, :masked_pan]
end
