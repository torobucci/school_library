class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    book.rentals << self
    @person = person
    person.rentals << self
  end

  def to_json(*args)
    {
      'date' => @date,
      'book' => @book.to_json,
      'person' => @person.to_json
    }.to_json(*args)
  end

  def self.from_json(json_data, books, people)
    rental_data = JSON.parse(json_data)
    book = find_book_by_title(JSON.parse(rental_data['book'])['title'], books)
    person = find_person_by_id(JSON.parse(rental_data['person'])['id'], people)

    Rental.new(rental_data['date'], book, person)
  end

  def self.find_book_by_title(title, books)
    books.find { |book| book.title == title }
  end

  def self.find_person_by_id(id, people)
    people.find { |person| person.id == id.to_i }
  end
end
