require_relative './app'
def main
  app = App.new
  puts "Welcome to the School Library App!"

  def options(app)
    menu_options = [
      "1 - List all books",
      "2 - List all people",
      "3 - Create a person",
      "4 - Create a book",
      "5 - Create a rental",
      "6 - List all rentals for a given person id",
      "7 - Exit"
    ]
    puts "\nPlease choose an option by entering a number:"
    puts menu_options.join("\n")
    number = gets.chomp.to_i

    case number
    when 1
      app.list_all_books
      options(app)
    when 2
      app.list_all_people
      options(app)
    when 3
      app.create_person
      options(app)
    when 4
      app.create_book
      options(app)
    when 5
      app.create_rental
      options(app)
    when 6
      app.list_rentals_of_person
      options(app)
    when 7
      puts "Thank you for using this app!"
      exit
    end
  end

  options(app)
end

main

