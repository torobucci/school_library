require_relative './app'
require_relative './options'
def main
  app = App.new
  app.load_data
  puts 'Welcome to the School Library App!'
  options(app)
end

main
