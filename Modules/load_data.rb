module LoadData

  def load_data
    load_books
    load_people
    load_rentals
  end

  def load_books
    if File.exist?('./books.json') && !File.zero?('./books.json')
      json_data = File.read('./books.json')
      @books = JSON.parse(json_data).map { |book_data| Book.from_json(book_data) }
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
  def load_rentals
    if File.exist?('./rentals.json') && !File.zero?('./rentals.json')
      json_data = File.read('./rentals.json')
      @rentals = JSON.parse(json_data).map do |rental_data|
        Rental.from_json(rental_data, @books, @people)
      end
    end
  end
end
