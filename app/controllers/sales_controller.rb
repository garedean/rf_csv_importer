class SalesController < ApplicationController
  def csv_import
    csv_file = params[:csv_file]

    if csv_file
      redirect_to root_path, notice: 'CSV imported'
    else
      redirect_to root_path, notice: 'File missing'
    end
  end
end
