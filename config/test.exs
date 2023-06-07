import Config

config :exvcr,
  vcr_cassette_library_dir: "fixture/vcr_cassettes",
  filter_sensitive_data: [
    [pattern: "<PASSWORD>.+</PASSWORD>", placeholder: "PASSWORD_PLACEHOLDER"]
  ],
  filter_url_params: false,
  filter_request_headers: ["X-Token"],
  response_headers_blacklist: []

config :ex_monobank,
  base_url: "https://api.monobank.ua",
  private_api: %{
    token: System.get_env("MONOBANK_API_TOKEN")
  }
