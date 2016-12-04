class SalesController < ApplicationController
  def csv_import_file_selection
    @revenue_for_all_sales = Sale.revenue_for_all_sales
  end

  def csv_import
    if csv_file
      batch_revenue = Sale.csv_import(csv_file)

      set_import_success_flashes(batch_revenue: batch_revenue)
    else
      flash[:notice] = 'File missing'
    end
  rescue CSV::MalformedCSVError
    flash[:notice] = 'Error importing CSV. Check file formatting'
  ensure
    redirect_to root_path
  end

  private

  def csv_file
    params[:csv_file]
  end

  def set_import_success_flashes(batch_revenue:)
    flash[:imported_batch_revenue] = batch_revenue
    flash[:notice] = 'CSV imported'
  end
end
