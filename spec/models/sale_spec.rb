require 'rails_helper'

describe Sale do
  describe '.csv_import' do
    let(:uploaded_csv_file) {
      csv_file = File.new(Rails.root + 'spec/fixtures/sales_test_data.csv')
      ActionDispatch::Http::UploadedFile.new(tempfile: csv_file)
    }

    it "saves the 'purchase_count'" do
      Sale.csv_import(uploaded_csv_file)

      expect(Sale.first.purchase_count).to eq 2
    end

    context 'saving purchaser data' do
      it "saves purchaser's name" do
        Sale.csv_import(uploaded_csv_file)

        expect(Sale.first.purchaser.name).to eq 'Snake Plissken'
      end

      it "only saves one unique purchaser based on purchaser name" do
        Sale.csv_import(uploaded_csv_file)

        expect(Purchaser.where(name: 'Snake Plissken').count).to eq 1
      end
    end

    context 'saving item data' do
      it 'saves an item description' do
        Sale.csv_import(uploaded_csv_file)

        expect(Sale.first.item_description).to eq '$10 off $20 of food'
      end

      it 'only saves one unique item based on description and price' do
        Sale.csv_import(uploaded_csv_file)

        expect(Item.where(description: '$20 Sneakers for $5', price: 5.0).count).to eq 1
      end
    end
  end
end
