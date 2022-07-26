require 'json'

module PeoplePersistence
  def store_people(people)
    data = []
    file = 'people.json'
    return unless File.exist?(file)

    people.each do |person|
      case person
      when Teacher
        data << { age: person.age, specialization: person.specialization, name: person.name }
      when Student
        data << { age: person.age, classroom: person.classroom, name: person.name,
                  parent_permission: person.parent_permission }
      end
    end
    File.write(file, JSON.generate(data))
  end

  def load_people
    data = []
    file = 'people.json'
    return unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |person|
      case person
      when Teacher
        data << Teacher.new(person['age'], person['specialization'], person['name'])
      when Student
        data << Student.new(person['age'], person['classroom'], person['name'],
                            parent_permission: person['parent_permission'])
      end
    end

    data
  end
end
