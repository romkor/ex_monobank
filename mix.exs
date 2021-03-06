defmodule ExMonobank.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_monobank,
      version: "2.2.0",
      elixir: "~> 1.10",
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
      files: ["lib", "lib/ex_monobank", "config/config.exs", "mix.exs", "README*"],
      maintainers: ["Roman Rodych"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/romkor/ex_monobank"}
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.4.0"},
      {:jason, ">= 1.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
