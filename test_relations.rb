require_relative './person'
require_relative './capitalize_decorator'
require_relative './trimmer_decorator'
require_relative './student'
require_relative './classroom'
require_relative './rental'
require_relative './book'

west = Classroom.new('west')
student1 = Student.new(22, west, 'kevin')
p student1.classroom.label
book1 = Book.new('GOT', 'George RR')
p book1
rental1 = Rental.new('2020-03-01', book1, student1)
p(rental1.book.rentals.map(&:date))
