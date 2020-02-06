defmodule ExMonobank.PersonalAPI do
  @moduledoc """
  Documentation for ExMonobank.PersonalAPI
  """

  use Tesla, only: ~w(get post)a, docs: false

  plug(
    Tesla.Middleware.BaseUrl,
    Application.get_env(
      :ex_monobank,
      :private_api
    )[:base_url] || "https://api.monobank.ua"
  )

  plug(Tesla.Middleware.Headers, [
    {"X-Token", Application.get_env(:ex_monobank, :private_api)[:token]}
  ])

  plug(Tesla.Middleware.JSON)

  @doc """
  Get client's accounts info.
  """
  def client_info do
    case get("/personal/client-info") do
      {:ok, response} ->
        body = response.body

        {:ok, body}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get client's default account statements for a period from given date to now
  """
  def statement(from) do
    statement(0, from)
  end

  @doc """
  Get client's account statements for a period from given date to now
  """
  def statement(account, from) do
    case get("/personal/statement/#{account}/#{DateTime.to_unix(from)}") do
      {:ok, response} ->
        body = response.body

        {:ok, body}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get client's account statements for a given period
  """
  def statement(account, from, to) do
    case get("/personal/statement/#{account}/#{DateTime.to_unix(from)}/#{DateTime.to_unix(to)}") do
      {:ok, response} ->
        body = response.body

        {:ok, body}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Set webhook
  """
  def webhook(url) do
    case post("/personal/webhook", %{:webHookUrl => url}) do
      {:ok, _response} ->
        {:ok}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
