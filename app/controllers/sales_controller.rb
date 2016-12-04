class SalesController < ApplicationController
  def csv_import_file_selection
    @revenue_for_all_sales = Sale.revenue_for_all_sales
  end

  def csv_import
    set_flash_notice('File missing'); return unless csv_file

    Sale.csv_import(csv_file)
    set_flash_notice('CSV imported')
  rescue CSV::MalformedCSVError
    set_flash_notice('Error importing CSV. Check file formatting')
  ensure
    redirect_to root_path
  end

  private

  def csv_file
    params[:csv_file]
  end

  def set_flash_notice(message)
    flash[:notice] = message
  end
end
