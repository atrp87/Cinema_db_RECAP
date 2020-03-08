require_relative("../db/sql_runner")
require_relative("films")

class Customers

  attr_reader   :id
  attr_accessor :name, :funds

  def initialize( options )
    @id    = options['id'].to_i if options['id']
    @name  = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name, funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customers = SqlRunner.run( sql, values ).first
    @id = customers['id'].to_i
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.films_id = films.id WHERE customers_id = $1"
    values     = [@id]
    films      = SqlRunner.run(sql, values)
    result     = films.map {|film|  Films.new(film)}
    return result
  end

  def update
    sql = "UPDATE screenings SET (
          film_id, funds) = ($1, $2)
          WHERE id = $3"
    values = [@film_id, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customers.new( customer ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
