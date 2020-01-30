defmodule ExMonobank.PersonalAPI do
  @moduledoc """
  Documentation for ExMonobank.PersonalAPI
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.monobank.ua")
  plug(Tesla.Middleware.JSON)

  @doc """
  Get bank currency exchange rates.
  """
  def bank_currency do
    case get("/bank/currency") do
      {:ok, response} ->
        body = Enum.map(response.body, &map_to_currency_info/1)

        {:ok, body}

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
