require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

class App
  def initialize
    @people = Person.class_variable_get(:@@people)
    @books = Book.class_variable_get(:@@books)
  end

  def run
    puts 'Welcome to School Library App!'
    loop do
      puts '-' * 50
      puts '
          1- List all books
          2- List all people
          3- Create a new person
          4- Create a new book entry
          5- Create a new rental entry
          6- List all rentals for a given person id
          7- Quit'
      print 'Choose an option: '
      input = gets.chomp.to_i

      break if input == 7

      operation(input)
    end
  end

  def operation(input)
    case input
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    else
      puts 'Please choose a valid option number'
    end
  end

  def list_books
    puts '-' * 50
    if @books.empty?
      puts 'The books list is empty'
    else
      puts 'Books list:'
      @books.each_with_index do |book, index|
        puts "#{index + 1}-[Book] Title: #{book.title} | Author: #{book.author}"
      end
    end
  end

  def list_people
    puts '-' * 50
    if @people.empty?
      puts "The people\'s list is empty"
    else
      puts 'People list:'
      @people.each_with_index do |per, i|
        puts "#{i + 1}-[Teacher] ID: #{per.id} | Name: #{per.name} | Age: #{per.age}" if per.is_a?(Teacher)
        puts "#{i + 1}-[Student] ID: #{per.id} | Name: #{per.name} | Age: #{per.age}" if per.is_a?(Student)
      end
    end
  end

  def create_person
    puts '-' * 50
    print 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
    option = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp
    case option
    when 1
      create_student(name, age)
    when 2
      create_teacher(name, age)
    else
      puts 'Please input a valid number (1 or 2)'
    end
  end

  def create_student(name, age)
    print "Has parent\'s persmission? [Y/N]: "
    parent_permission = gets.chomp
    parent_permission = true if parent_permission == ('y' || 'Y')
    parent_permission = false if parent_permission == ('n' || 'N')
    Student.new(age, 'class', name, parent_permission: parent_permission)
    puts "Student (#{name}) has been created successfully"
  end

  def create_teacher(name, age)
    print "Teacher\'s specialization: "
    specialization = gets.chomp
    Teacher.new(age, specialization, name)
    puts "Teacher (#{name}) has been created successfully"
  end

  def create_book
    print "Book\'s title: "
    title = gets.chomp
    print "Book\'s author: "
    author = gets.chomp
    Book.new(title, author)
    puts "Book (#{title} By #{author}) has been created successfully"
  end

  def create_rental
    if @books.empty?
      puts 'Books list is empty, please create a book first'
    elsif @people.empty?
      puts "People\'s list is empty, please create a person first"
    else
      puts 'Select a book from the following list by number'
      list_books
      book_number = gets.chomp.to_i
      puts 'Select a person from the following list by number'
      list_people
      person_number = gets.chomp.to_i
      print 'Date: '
      date = gets.chomp
      Rental.new(date, @books[book_number - 1], @people[person_number - 1])
      puts 'Rental has been created successfully'
    end
  end

  def list_rentals
    list_people
    print "Person\'s ID: "
    input_id = gets.chomp.to_i
    selected_person = @people.select { |person| person.id == input_id }
    if selected_person.empty? || selected_person[0].rentals.empty?
      puts "No rentals are found for (#{input_id})"
    else
      selected_person[0].rentals.each do |rental|
        puts "Date: #{rental.date} | Book: #{rental.book.title} By #{rental.book.author}"
      end
    end
  end
end
