require 'rails_helper'

describe Sale do
  describe '.csv_import' do
    it "saves the 'purchase_count' for a sale" do
      csv_file = File.new(Rails.root + 'spec/fixtures/sales_test_data.csv')
      uploaded_csv_file = ActionDispatch::Http::UploadedFile.new(tempfile: csv_file)

      Sale.csv_import(uploaded_csv_file)

      expect(Sale.first.purchase_count).to eq 2
    end
  end
end
