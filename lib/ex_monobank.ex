defmodule ExMonobank do
  @moduledoc """
  Documentation for ExMonobank.
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
        body =
          Enum.map(response.body, fn x ->
            Map.update!(x, "date", &DateTime.from_unix!(&1))
          end)

        {:ok, body}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
