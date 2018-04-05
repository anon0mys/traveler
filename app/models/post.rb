class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location
  accepts_nested_attributes_for :location

  def self.all_countries
    require 'csv'
    @all_countries ||= csv_reader
  end

  def self.csv_reader
    data = CSV.open('./db/all_countries.csv', headers: true, header_converters: :symbol)
    data.map do |row|
      row[:name]
    end
  end
end
