class SalesController < ApplicationController
  def csv_import
    csv_file = params[:csv_file]

    if csv_file
      Sale.csv_import(csv_file)
    else
      redirect_to root_path, notice: 'File missing'
    end
  end
end
