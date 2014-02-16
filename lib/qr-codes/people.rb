require 'csv'
require_relative 'person'

class People
  def self.from_csv(file)
    CSV.read(file).drop(1).map { |row|
      Person.new(*row.values_at(1,2,3,4,5,6,7,8,9,12)) }
  end
end
