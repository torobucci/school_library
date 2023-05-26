require_relative './people/person'
require_relative './people/student'
require_relative './people/teacher'
require_relative './book'
require_relative './rental'
class App
  attr_accessor :books, :people

  def initialize
    @books = []
    @people = []
  end

  def list_all_books
    if @books.empty?
      puts "No books available"
    else
      @books.each do |book|
        puts "Title: '#{book.title}', Author: #{book.author}"
      end
    end
  end


  def list_all_people
    if @people.empty?
      puts "No person created"
    else
      @people.each do |person|
        puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def create_person
    print 'Do you want to create a student(1) or a teacher(2)? [Input the number]:'
    choice = gets.chomp.to_i

    case choice
    when 1
      # Method to create a student
      def create_student
        print 'Age: '
        age = gets.chomp.to_i
        print 'Name: '
        name = gets.chomp
        print 'Has parent permission? [Y/N]: '
        parent_permission = gets.chomp
        parent_permission = !(parent_permission.downcase == 'n')
        student = Student.new(age, name, parent_permission:parent_permission)
        puts 'Person created successfully'
        @people << student
      end
      create_student
    when 2
      # Method to create a teacher
      def create_teacher
        print 'Age: '
        age = gets.chomp.to_i
        print 'Name: '
        name = gets.chomp
        print 'Specialization: '
        specialization = gets.chomp
        teacher = Teacher.new(age, specialization, name)
        puts 'Person created successfully'
        @people << teacher
      end
      create_teacher
    else
      puts 'Invalid choice. Please try again.'
      create_person
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title,author)
    puts 'Book created successfully'
    @books << book
  end

  def create_rental
    if @books.empty?
      puts "No books available to rent"
    else
      puts 'Select a book from the following list by number'
      @books.each_with_index do |book, index|
        puts "#{index}) Title: #{book.title}, Author: #{book.author}"
      end
      index = gets.chomp.to_i
      book_selected = @books[index]

      if @people.empty?
        puts "No persons created. Kindly create person before renting"
      else
        puts 'Select a person from the following list (not id)'
        @people.each_with_index do |person, index|
          puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        end
        index = gets.chomp.to_i
        person_selected = @people[index]
        print "Date: "
        date = gets.chomp
        rental = Rental.new(date,book_selected,person_selected)
        puts 'Rental created successfully'
      end
    end
  end

  def list_rentals_of_person
    print "ID of Person: "
    id = gets.chomp.to_i
    person = @people.select { |person| person.id == id }.first
    if person.nil?
      puts "No such person exists"
    else
      puts "Rentals: "
      person.rentals.map { |rental| puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}" }
    end
  end
end
