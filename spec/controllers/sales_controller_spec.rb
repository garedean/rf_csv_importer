require 'rails_helper'

RSpec.describe SalesController do
  describe 'POST #csv_import' do
    def upload_csv
      csv_fixture_path = Rails.root + 'spec/fixtures/malformed_sales_test_data.csv'
      csv_file = fixture_file_upload(csv_fixture_path, 'text/csv')
      
      post :csv_import, csv_file: csv_file
    end

    context 'valid CSV' do
      def stub_csv_import
        allow(Sale).to receive(:csv_import)
      end

      it 'sets the flash message' do
        stub_csv_import

        upload_csv

        expect(flash[:notice]).to eq 'CSV imported'
      end

      it 'imports CSV data' do
        stub_csv_import

        upload_csv

        expect(Sale).to have_received(:csv_import).with(subject.params[:csv_file])
      end

      it 'redirects to root_path' do
        stub_csv_import

        upload_csv

        expect(response).to redirect_to root_path
      end
    end

    context 'malformed CSV' do
      it 'sets the flash message' do
        upload_csv

        expect(flash[:notice]).to eq 'Error importing CSV. Check file formatting'
      end

      it 'redirects to root_path' do
        allow(CSV).to receive(:foreach).and_raise(CSV::MalformedCSVError)

        upload_csv

        expect(response).to redirect_to root_path
      end
    end

    context 'missing CSV' do
      it 'sets the flash message' do
        post :csv_import

        expect(flash[:notice]).to eq 'File missing'
      end

      it 'redirects to root_path' do
        post :csv_import

        expect(response).to redirect_to root_path
      end
    end
  end
end
