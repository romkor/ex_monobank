defmodule ExMonobank.Invoice do
  @derive Jason.Encoder
  @enforce_keys [:amount]
  defstruct [
    :amount,
    :ccy,
    :merchantPaymInfo,
    :redirectUrl,
    :webhookUrl,
    :validity,
    :paymentType,
    :qrId,
    :saveCardData
  ]

  def new(attrs) do
    struct(__MODULE__, attrs)
  end
end
