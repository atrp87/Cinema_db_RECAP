require_relative("../db/sql_runner")
require_relative('customers.rb')

class Films

  attr_reader   :id
  attr_accessor :title, :price

  def initialize( options )
    @id    = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
    (
      title, price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film   = SqlRunner.run( sql, values ).first
    @id    = film['id'].to_i
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customers_id = customers.id WHERE films_id = $1"
    values = [@id]
    customer = SqlRunner.run(sql, values)
    return Customers.map_items(customer)
  end

  def Films.map_items(customer_data)
    result = customer_data.map {|customer| Customers.new(customer)}
    return result
  end

  def self.all()
    sql    = "SELECT * FROM films"
    film  = SqlRunner.run(sql)
    result = Films.map { |film| Films.new( film )}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
