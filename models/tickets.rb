require_relative("../db/sql_runner")
require_relative("films.rb")
require_relative("customers.rb")

class Tickets

  attr_reader   :id
  attr_accessor :customers_id, :films_id

  def initialize( options )
    @id           = options['id'].to_i if options['id']
    @customers_id = options['customers_id'].to_i
    @films_id     = options['films_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customers_id, films_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customers_id, @films_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def customer()
    sql      = "SELECT * FROM customers WHERE customers.id = $1"
    values   = [@customers_id]
    customer = SqlRunner.run(sql, values).first
    return Customers.new(customer)
  end

  def films()
    sql    = "SELECT * FROM films WHERE films.id = $1"
    values = [@films_id]
    film   = SqlRunner.run(sql, values).first
    return  Films.new(film)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    ticket = SqlRunner.run(sql)
    result  = ticket.map { |ticket| Tickets.new( ticket )}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
