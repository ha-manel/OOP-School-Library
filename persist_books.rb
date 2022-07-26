require 'json'

module BooksPersistence
  def store_books(books)
    data = []
    file = 'books.json'
    if File.exists?(file)
      books.each do |book|
        data << {title: book.title, author: book.author}
      end
      File.write(file, JSON.generate(data))
    end
  end

  def load_books
    data = []
    file = 'books.json'
    if File.exists?(file) && File.read(file) != ''
      JSON.parse(File.read(file)).each do |book|
        data << Book.new(book['title'], book['author'])
      end
    end
    data
  end
end