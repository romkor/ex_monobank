defmodule ExMonobank.MerchantAPI do
  @moduledoc """
  Documentation for ExMonobank.MerchantAPI
  """

  use Tesla, only: [:post], docs: false

  plug(
    Tesla.Middleware.BaseUrl,
    Application.get_env(
      :ex_monobank,
      :base_url,
      ExMonobank.default_url()
    )
  )

  plug(Tesla.Middleware.Headers, [
    {"X-Token", Application.get_env(:ex_monobank, :private_api)[:token]}
  ])

  plug(Tesla.Middleware.JSON)

  if Mix.env() == :dev do
    plug(Tesla.Middleware.Logger)
  end

  @invoice_create_endpoint "/api/merchant/invoice/create"

  @doc """
  Create invoice for payment
  attrs = %{
    amount: 100
  }
  """
  def create_invoice(%ExMonobank.Invoice{} = invoice) do
    post(@invoice_create_endpoint, invoice)
    |> case do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 400 ->
        {:ok, map_to_invoice_info(body)}

      {:ok, %{body: %{"errText" => reason}}} ->
        {:error, reason}

      {:error, reason} ->
        reason |> dbg()
        {:error, reason}
    end
  end

  defp map_to_invoice_info(%{"invoiceId" => id, "pageUrl" => url}) do
    struct(ExMonobank.InvoiceInfo, %{id: id, page_url: url})
  end
end
