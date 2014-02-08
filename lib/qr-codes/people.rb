require 'csv'
require_relative 'person'

class People
  def self.from_csv(file)
    CSV.read(file).map { |row| Person.new(*row.values_at(1,2,4,5,3,8,6)) }
  end
end
