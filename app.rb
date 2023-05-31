require_relative './people/person'
require_relative './people/student'
require_relative './people/teacher'
require_relative './book'
require_relative './rental'
require_relative './user_input'
require 'json'
class App
  include UserInput
  attr_accessor :books, :people

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    if @books.empty?
      puts 'No books available'
    else
      @books.each do |book|
        puts "Title: '#{book.title}', Author: #{book.author}"
      end
    end
  end

  def list_all_people
    if @people.empty?
      puts 'No person created'
    else
      @people.each do |person|
        puts "[#{person.class}] Name: #{person.name}', ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_person
    choice = user_input(['Do you want to create a student(1) or a teacher(2)? [Input the number]']).to_i

    case choice
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid choice. Please try again.'
      create_person
    end
  end

  def create_student
    age, name, parent_permission = user_input(['Age', 'Name', 'Has parent permission? [Y/N]'])
    parent_permission = parent_permission.downcase != 'n'

    student = Student.new(age.to_i, name, parent_permission: parent_permission)
    puts 'Person created successfully'
    @people << student
  end

  def create_teacher
    age, name, specialization = user_input(%w[Age Name Specialization])

    teacher = Teacher.new(age.to_i, specialization, name)
    puts 'Person created successfully'
    @people << teacher
  end

  def create_book
    title, author = user_input(%w[Title Author])

    book = Book.new(title, author)
    puts 'Book created successfully'
    @books << book
  end

  def create_rental
    if @books.empty?
      puts 'No books available to rent'
    else
      puts 'Select a book from the following list by number'
      display_books

      if @people.empty?
        puts 'No persons created. Kindly create a person before renting'
      else
        puts 'Select a person from the following list (not id)'
        display_people

        date = user_input(['Date'])

        @rentals << Rental.new(date, @selected_book, @selected_person)
        puts 'Rental created successfully'
      end
    end
  end

  def display_books
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    index = gets.chomp.to_i
    @selected_book = @books[index]
  end

  def display_people
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    index = gets.chomp.to_i
    @selected_person = @people[index]
  end

  def list_rentals_of_person
    id = user_input(['ID of Person'])
    rentals = @rentals.filter { |rental| rental.person.id == id.to_i }

    if rentals.empty?
      puts 'There are currently no rentals for this person!'
    else
      puts 'Rentals:'
      rentals.each do |rental|
        puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
      end
    end
  end

  def exit_app
    save_books
    save_people
    # save_rentals
    puts 'Thank you for using this app!'
    exit
  end

  def load_books
    if File.exist?('./books.json') && !File.zero?('./books.json')
      json_data = File.read('./books.json')
      @books = JSON.parse(json_data).map { |book_data| Book.from_json(book_data) }
    end
  end

  def save_books
    File.open('./books.json', 'w') do |file|
      json_data = JSON.pretty_generate(@books.map(&:to_json))
      file.write(json_data)
    end
  end

  def save_people
    File.open('./people.json', 'w') do |file|
      json_data = JSON.pretty_generate(@people.map(&:to_json))
      file.write(json_data)
    end
  end

  def load_people
    if File.exist?('./people.json') && !File.zero?('./people.json')
      json_data = File.read('./people.json')
      parsed_data = JSON.parse(json_data)
      @people = parsed_data.map do |person_data|
        case JSON.parse(person_data)['type']
        when 'Student'
          Student.from_json(person_data)
        when 'Teacher'
          Teacher.from_json(person_data)
        end
      end
    end
  end

end
