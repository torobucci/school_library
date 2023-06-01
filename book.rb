class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def to_json(*args)
    {
      'title' => @title,
      'author' => @author
    }.to_json(*args)
  end

  def self.from_json(json)
    data = JSON.parse(json)
    new(data['title'], data['author'])
  end
end
