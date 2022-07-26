class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    person.rentals << self unless person.rentals.include? self
    book.rentals << self unless book.rentals.include? self
  end
end
