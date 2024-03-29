require 'rails_helper'

RSpec.describe SalesController do
  def import_valid_csv
    import_csv('spec/fixtures/sales_test_data.csv')
  end

  def import_invalid_csv
    import_csv('spec/fixtures/malformed_sales_test_data.csv')
  end

  def import_csv(path)
    csv_fixture_path = Rails.root + path
    csv_file = fixture_file_upload(csv_fixture_path, 'text/csv')

    post :csv_import, csv_file: csv_file
  end

  describe 'GET #csv_import_file_selection' do
    it 'assigns revenue_for_all_sales' do
      import_valid_csv

      get :csv_import_file_selection

      expect(assigns[:revenue_for_all_sales]).to eq 95.0
    end
  end

  describe 'POST #csv_import' do
    context 'valid CSV' do
      def stub_csv_import
        allow(Sale).to receive(:csv_import).and_return(95.00)
      end

      it 'sets the flash notice message' do
        stub_csv_import

        import_valid_csv

        expect(flash[:notice]).to eq 'CSV imported'
      end

      it 'sets the flash imported_batch_revenue message' do
        stub_csv_import

        import_valid_csv

        expect(flash[:imported_batch_revenue]).to eq 95.00
      end

      it 'imports CSV data' do
        stub_csv_import

        import_valid_csv

        expect(Sale).to have_received(:csv_import).with(subject.params[:csv_file])
      end

      it 'redirects to root_path' do
        stub_csv_import

        import_valid_csv

        expect(response).to redirect_to root_path
      end
    end

    context 'malformed CSV' do
      it 'sets the flash message' do
        import_invalid_csv

        expect(flash[:notice]).to eq 'Error importing CSV. Check file formatting'
      end

      it 'redirects to root_path' do
        allow(CSV).to receive(:foreach).and_raise(CSV::MalformedCSVError)

        import_invalid_csv

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
