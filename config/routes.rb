Rails.application.routes.draw do
  root to: 'sales#csv_import_file_selection'

  post :import_sales, to: 'sales#csv_import'
end
