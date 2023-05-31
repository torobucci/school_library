require_relative './person'
class Student < Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def self.from_json(json_data)
    parsed_data = JSON.parse(json_data)
    self.new(parsed_data['age'], parsed_data['name'], parent_permission: parsed_data['parent_permission'])
  end

end
