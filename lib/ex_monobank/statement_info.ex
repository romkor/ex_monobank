defmodule ExMonobank.StatementInfo do
  @enforce_keys [
    :id,
    :amount,
    :balance,
    :cashback_amount,
    :commission_rate,
    :currency_code,
    :description,
    :hold,
    :mcc,
    :operation_amount,
    :time
  ]
  defstruct [
    :id,
    :amount,
    :balance,
    :cashback_amount,
    :commission_rate,
    :currency_code,
    :description,
    :hold,
    :mcc,
    :operation_amount,
    :time,
    :account_id
  ]
end
