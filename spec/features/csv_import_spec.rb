require 'rails_helper'

feature 'CSV Import' do
  scenario 'shows the CSV import page at the root path' do
    visit root_path

    expect(page).to have_content "Import Sales from CSV"
  end

  scenario 'shows file missing message on import' do
    visit root_path

    click_button 'Import'

    expect(page).to have_content 'File missing'
  end

  scenario 'show success message with successful file import' do
    visit root_path

    file_path = Rails.root + 'spec/fixtures/sales_test_data.csv'
    attach_file('csv_file', file_path)
    click_button 'Import'

    expect(page).to have_content 'CSV imported'
  end

  scenario 'shows error message when malformed CSV provided' do
    visit root_path

    file_path = Rails.root + 'spec/fixtures/malformed_sales_test_data.csv'
    attach_file('csv_file', file_path)
    click_button 'Import'

    expect(page).to have_content 'Error importing CSV. Check file formatting'
  end
end
