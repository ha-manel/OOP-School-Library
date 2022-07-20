class Rental
  def initialize(date, book, person)
    @date = date
    @book = book
    @rentee = person
  end

  attr_accessor :date
end
