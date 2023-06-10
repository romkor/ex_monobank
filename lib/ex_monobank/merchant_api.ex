defmodule ExMonobank.MerchantAPI do
  @moduledoc """
  Documentation for ExMonobank.MerchantAPI https://api.monobank.ua/docs/acquiring.html
  """

  use Tesla, only: [:get, :post], docs: false

  plug(
    Tesla.Middleware.BaseUrl,
    Application.get_env(
      :ex_monobank,
      :base_url,
      ExMonobank.default_url()
    )
  )

  plug(Tesla.Middleware.Headers, [
    {"X-Token", Application.get_env(:ex_monobank, :merchant_api)[:token]}
  ])

  plug(Tesla.Middleware.JSON)

  if Mix.env() == :dev do
    plug(Tesla.Middleware.Logger)
  end

  @doc """
  Create invoice
  https://api.monobank.ua/docs/acquiring.html#/paths/~1api~1merchant~1invoice~1create/post
  """
  def create_invoice(%ExMonobank.Invoice{} = invoice) do
    case post("/api/merchant/invoice/create", invoice) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 400 ->
        {:ok, map_to_invoice_info(body)}

      {:ok, %{body: %{"errText" => reason}}} ->
        {:error, reason}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get invoice status
  https://api.monobank.ua/docs/acquiring.html#/paths/~1api~1merchant~1invoice~1status?invoiceId=%7BinvoiceId%7D/get
  """
  def get_invoice_status(id) do
    case get("/api/merchant/invoice/status", query: %{invoiceId: id}) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 400 ->
        {:ok, map_to_invoice_info(body)}

      {:ok, %{body: %{"errText" => reason}}} ->
        {:error, reason}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Cancel invoice
  https://api.monobank.ua/docs/acquiring.html#/paths/~1api~1merchant~1invoice~1cancel/post
  """
  def cancel_invoice(id, extra \\ %{}) do
    case post("/api/merchant/invoice/cancel", Map.merge(%{invoiceId: id}, extra)) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 400 ->
        {:ok, map_to_invoice_info(body)}

      {:ok, %{body: %{"errText" => reason}}} ->
        {:error, reason}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Remove invoice
  https://api.monobank.ua/docs/acquiring.html#/paths/~1api~1merchant~1invoice~1remove/post
  """
  def remove_invoice(id) do
    case post("/api/merchant/invoice/remove", %{invoiceId: id}) do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 400 ->
        {:ok, map_to_invoice_info(body)}

      {:ok, %{body: %{"errText" => reason}}} ->
        {:error, reason}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp map_to_invoice_info(%{"invoiceId" => id, "pageUrl" => url}) do
    struct(ExMonobank.InvoiceInfo, %{id: id, page_url: url})
  end

  defp map_to_invoice_info(%{
         "invoiceId" => id,
         "status" => status,
         "amount" => amount,
         "ccy" => ccy,
         "createdDate" => created_date,
         "modifiedDate" => modified_date
       }) do
    {:ok, created_at, 0} = DateTime.from_iso8601(created_date)
    {:ok, modified_at, 0} = DateTime.from_iso8601(modified_date)

    struct(ExMonobank.InvoiceInfo, %{
      id: id,
      status: status,
      amount: amount,
      ccy: ccy,
      created_at: created_at,
      modified_at: modified_at
    })
  end

  defp map_to_invoice_info(%{
         "status" => status,
         "createdDate" => created_date,
         "modifiedDate" => modified_date
       }) do
    {:ok, created_at, 0} = DateTime.from_iso8601(created_date)
    {:ok, modified_at, 0} = DateTime.from_iso8601(modified_date)

    struct(ExMonobank.InvoiceInfo, %{
      status: status,
      created_at: created_at,
      modified_at: modified_at
    })
  end

  defp map_to_invoice_info(%{"status" => status}) do
    struct(ExMonobank.InvoiceInfo, %{status: status})
  end
end
