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
        {:error, error} =
          %{}
          |> ExMonobank.Invoice.new()
          |> MerchantAPI.create_invoice()

        assert error == "invalid 'amount'"
      end
    end

    test "failure with non-integer amount" do
      use_cassette "MerchantAPI/create_invoice_failure_with_invalid_amount" do
        {:error, error} =
          %{amount: "amount"}
          |> ExMonobank.Invoice.new()
          |> MerchantAPI.create_invoice()

        assert error ==
                 "json unmarshal: : json: cannot unmarshal string into Go struct field InvoiceCreateRequest.amount of type int64"
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

  describe "get_invoice_status/1" do
    test "success with valid invoiceId" do
      use_cassette "MerchantAPI/get_invoice_status_success_with_valid_id" do
        {:ok, %ExMonobank.InvoiceInfo{} = invoice} =
          MerchantAPI.get_invoice_status("230605DpurVjPDSmfzEP")

        assert invoice.id == "230605DpurVjPDSmfzEP"
        assert invoice.status == "created"
        assert invoice.amount == 100
        assert invoice.ccy == 980
        assert invoice.created_at == ~U[2023-06-05 16:38:48Z]
        assert invoice.modified_at == ~U[2023-06-05 16:38:48Z]
      end
    end

    test "failure with invalid invoiceId" do
      use_cassette "MerchantAPI/get_invoice_status_failure_with_inbvalid_id" do
        {:error, error} = MerchantAPI.get_invoice_status("invalid")
        assert error == "invoice not found"
      end
    end
  end

  describe "cancel_invoice/1" do
    # TODO: How to cancel test order?
    @tag :focus
    test "success with valid invoiceId" do
      use_cassette "MerchantAPI/cancel_invoice_success_with_valid_id" do
        {:ok, %ExMonobank.InvoiceInfo{} = invoice} =
          MerchantAPI.cancel_invoice("230605DpurVjPDSmfzEP")

        assert invoice.status == "success"
        assert invoice.created_at == ~U[2023-06-05 17:59:28Z]
        assert invoice.modified_at == ~U[2023-06-05 17:59:28Z]
      end
    end

    @tag :focus
    test "failure with invalid invoiceId" do
      use_cassette "MerchantAPI/cancel_invoice_failure_with_inbvalid_id" do
        {:error, error} = MerchantAPI.cancel_invoice("invalid")
        assert error == "invoice not found"
      end
    end
  end
end
