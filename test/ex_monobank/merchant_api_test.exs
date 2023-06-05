defmodule ExMonobank.MerchantAPITest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExMonobank.MerchantAPI

  describe "create_invoice/1" do
    test "success with amount" do
      use_cassette "MerchantAPI/create_invoice_success_with_amount" do
        {:ok, %ExMonobank.InvoiceInfo{} = invoice} =
          %{amount: 100}
          |> ExMonobank.Invoice.new()
          |> MerchantAPI.create_invoice()

        assert invoice.id == "230605DpurVjPDSmfzEP"
        assert invoice.page_url == "https://pay.mbnk.biz/230605DpurVjPDSmfzEP"
      end
    end

    test "failure without amount" do
      use_cassette "MerchantAPI/create_invoice_failure_without_amount" do
        {:error, "invalid 'amount'"} =
          %{}
          |> ExMonobank.Invoice.new()
          |> MerchantAPI.create_invoice()
      end
    end

    test "failure with non-integer amount" do
      use_cassette "MerchantAPI/create_invoice_failure_with_invalid_amount" do
        {:error,
         "json unmarshal: : json: cannot unmarshal string into Go struct field InvoiceCreateRequest.amount of type int64"} ==
          %{amount: "amount"}
          |> ExMonobank.Invoice.new()
          |> MerchantAPI.create_invoice()
      end
    end

    test "success with full params" do
      use_cassette "MerchantAPI/create_invoice_success_with_full_params" do
        {:ok, %ExMonobank.InvoiceInfo{} = invoice} =
          %{
            amount: 100,
            ccy: 980,
            merchantPaymInfo: %{
              reference: "reference_id",
              destination: "destination_info",
              basketOrder: [
                %{
                  name: "TestItem",
                  qty: 2,
                  sum: 100
                }
              ]
            },
            redirectUrl: "https://localhost:4000/monopay/success",
            webhookUrl: "https://localhost:4000/api/v1/monopay/webhook",
            validity: 3600,
            paymentType: "debit",
            saveCard: %{
              saveCard: true,
              walletId: "ExMonobankWalletId"
            }
          }
          |> ExMonobank.Invoice.new()
          |> MerchantAPI.create_invoice()

        assert invoice.id == "2306058TJ5EYzZxFNuvv"
        assert invoice.page_url == "https://pay.mbnk.biz/2306058TJ5EYzZxFNuvv"
      end
    end
  end
end
