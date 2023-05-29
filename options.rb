def options(app)
  menu_options = {
    1 => :list_all_books,
    2 => :list_all_people,
    3 => :create_person,
    4 => :create_book,
    5 => :create_rental,
    6 => :list_rentals_of_person,
    7 => :exit_app
  }

  loop do
    puts "\nPlease choose an option by entering a number:"
    menu_options.each { |key, option| puts "#{key} - #{option.to_s.capitalize.gsub('_', ' ')}" }
    number = gets.chomp.to_i

    if menu_options.key?(number)
      app.send(menu_options[number])
    else
      puts 'Invalid option. Please try again.'
    end
  end
end
