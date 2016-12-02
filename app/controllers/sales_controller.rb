class SalesController < ApplicationController
  def csv_import
    csv_file = params[:csv_file]

    if csv_file
    else
      redirect_to :back, notice: 'File missing' unless csv_file
    end
  end
end
