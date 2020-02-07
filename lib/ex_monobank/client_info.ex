defmodule ExMonobank.ClientInfo do
  @enforce_keys [:id, :name, :web_hook_url, :accounts]
  defstruct [:id, :name, :web_hook_url, :accounts]
end
