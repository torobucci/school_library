require_relative './app'
require_relative './options'
def main
  app = App.new
  app.load_books
  app.load_people
  puts 'Welcome to the School Library App!'
  options(app)
end

main
