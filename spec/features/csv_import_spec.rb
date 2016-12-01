require 'rails_helper'

feature 'CSV Import' do
  scenario 'shows the CSV import page at the root path' do
    visit root_path

    expect(page).to have_content "Import Sales from CSV"
  end
end
