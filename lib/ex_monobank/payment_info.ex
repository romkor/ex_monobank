defmodule ExMonobank.PaymentInfo do
  @enforce_keys [
    :masked_pan,
    :approval_code,
    :rrn,
    :amount,
    :ccy,
    :final_amount,
    :terminal,
    :payment_scheme,
    :payment_method,
    :domestic_card,
    :country
  ]
  defstruct [
    :masked_pan,
    :approval_code,
    :rrn,
    :amount,
    :ccy,
    :final_amount,
    :created_at,
    :terminal,
    :payment_scheme,
    :payment_method,
    :fee,
    :domestic_card,
    :country
  ]
end
