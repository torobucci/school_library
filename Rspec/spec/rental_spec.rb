require_relative '../../rental'
require_relative '../../book'
require_relative '../../people/person'
require 'json'
require 'rspec'

describe Rental do
  let(:date) { '2023-05-30' }
  let(:book) { Book.new('Title', 'Author') }
  let(:person) { Person.new(25, 'John Doe') }
  let(:rental) { Rental.new(date, book, person) }

  describe '#initialize' do
    it 'sets the instance variables correctly' do
      expect(rental.date).to eq(date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end

    it 'adds the rental to the book and person' do
      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#to_json' do
    it 'returns the rental data in JSON format' do
      json_data = rental.to_json

      expect(json_data).to be_a(String)

      parsed_data = JSON.parse(json_data)
      expect(parsed_data['date']).to eq(date)
      expect(parsed_data['book']).to be_a(String)
      expect(parsed_data['person']).to be_a(String)
    end
  end

  describe '.from_json' do
    let(:books) { [book] }
    let(:people) { [person] }
    let(:json_data) do
      {
        'date' => date,
        'book' => book.to_json,
        'person' => person.to_json
      }.to_json
    end

    it 'creates a rental object from JSON data' do
      rental = Rental.from_json(json_data, books, people)

      expect(rental).to be_a(Rental)
      expect(rental.date).to eq(date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end
  end
  describe '.find_book_by_title' do
    let(:books) { [book] }

    it 'returns the book with the matching title' do
      found_book = Rental.find_book_by_title('Title', books)
      expect(found_book).to eq(book)
    end

    it 'returns nil if no book with the matching title is found' do
      found_book = Rental.find_book_by_title('Non-existent Title', books)
      expect(found_book).to be_nil
    end
  end
  describe '.find_person_by_id' do
    let(:people) { [person] }

    it 'returns the person with the matching ID' do
      found_person = Rental.find_person_by_id(person.id, people)
      expect(found_person).to eq(person)
    end

    it 'returns nil if no person with the matching ID is found' do
      found_person = Rental.find_person_by_id(123, people)
      expect(found_person).to be_nil
    end
  end
end