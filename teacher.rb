require_relative 'person'

class Teacher < Person
  def initialize(age, specialization, name = 'unknown')
    super(age, name)
    @specialization = specialization
  end

  def can_use_servies?
    true
  end
end
