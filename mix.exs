defmodule ExMonobank.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_monobank,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      description: "Monobank API (unofficial)",
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Roman Rodych"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/romkor/ex_monobank"}
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:jason, ">= 1.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
