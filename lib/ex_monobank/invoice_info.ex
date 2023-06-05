defmodule ExMonobank.InvoiceInfo do
  @enforce_keys [:id, :page_url]
  defstruct [:id, :page_url]
end
