require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  @@people = []

  def initialize(age, name = 'unknown', parent_permission = true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @@people << self
    @rentals = []
  end

  def of_age?
    @age >= 18
  end

  private :of_age?

  def can_use_servies?
    @age >= 18 || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(book, date)
    rental = Rental.new(date, book, self)
    @rentals << rental
  end
end
