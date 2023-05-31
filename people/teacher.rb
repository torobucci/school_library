require_relative './person'
class Teacher < Person
  def initialize(age, specialization, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_json(*args)
    {
      'type' => self.class.name,
      'id' => @id,
      'age' => @age,
      'name' => @name,
      'parent_permission' => @parent_permission,
      'specialization' => @specialization
    }.to_json(*args)
  end

  def self.from_json(json_data)
    parsed_data = JSON.parse(json_data)
    teacher = self.new(parsed_data['age'], parsed_data['specialization'], parsed_data['name'])
    teacher.id = parsed_data['id'].to_i
    teacher
  end
end
