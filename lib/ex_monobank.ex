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
    get("/bank/currency")
  end
end
