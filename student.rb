require_relative 'person'
require_relative 'classroom'

class Student < Person
  def initialize(age, name = 'unknown', parent_permission = true, classroom = nil)
    super(age, name, parent_permission)
    @classroom = Classroom.new(classroom)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students << self unless classroom.students.include?(self)
  end
end
