defmodule ExMonobank.PublicAPI do
  @moduledoc """
  Documentation for ExMonobank.PublicAPI
  """

  use Tesla, only: [:get], docs: false

  plug(
    Tesla.Middleware.BaseUrl,
    Application.get_env(
      :ex_monobank,
      :base_url,
      ExMonobank.default_url()
    )
  )

  plug(Tesla.Middleware.JSON)

  if Mix.env() == :dev do
    plug(Tesla.Middleware.Logger)
  end

  @doc """
  Get bank currency exchange rates.
  """
  def bank_currency do
    case get("/bank/currency") do
      {:ok, %{status: status, body: body}} when status >= 200 and status < 400 ->
        {:ok, Enum.map(body, &map_to_currency_info/1)}

      {:ok, %{body: %{"errorDescription" => reason}}} ->
        {:error, reason}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp map_to_currency_info(currency_map) do
    struct(
      ExMonobank.CurrencyInfo,
      %{
        currency_code_a: currency_map["currencyCodeA"],
        currency_code_b: currency_map["currencyCodeB"],
        date: DateTime.from_unix!(currency_map["date"]),
        rate_sell: currency_map["rateSell"],
        rate_buy: currency_map["rateBuy"],
        rate_cross: currency_map["rateCross"]
      }
    )
  end
end
