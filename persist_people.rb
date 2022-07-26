require 'json'

module PeoplePersistence
    def store_people(people)
        data = []
        file = 'people.json'
        if File.exists?(file) 
            people.each do | person | 
                if person.is_a?(Teacher)
                  data << {age: person.age,specialization: person.specialization,name: person.name}
                elsif person.is_a?(Student)
                    data << {age: person.age,classroom: person.classroom, name: person.name, parent_permission: person.parent_permission}
                end
            end
            File.write(file, JSON.generate(data))
        end
    end 

    def load_people
        data = []
        file = 'people.json'
        if File.exists?(file) && File.read(file) != ''
            JSON.parse(File.read(file)).each do |person|
                if person.is_a?(Teacher)
                    data << Teacher.new(person.age,person.specialization,person.name)
                elsif person.is_a?(Student)
                      data << Student.new( person.age, person.classroom, person.name, parent_permission: person.parent_permission)
                end
                
            end
        end
        data
    end
end