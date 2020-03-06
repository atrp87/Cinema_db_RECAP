require_relative( 'models/customers.rb' )
require_relative( 'models/films.rb' )
require_relative( 'models/tickets.rb' )

require('pry')

Tickets.delete_all()
Customers.delete_all()
Films.delete_all()

customer1 = Customers.new({ 'name' => 'Tom', 'funds' => 60 })
customer2 = Customers.new({ 'name' => 'Jessica', 'funds' => 80 })
customer3 = Customers.new({ 'name' => 'Dave', 'funds' => 20 })

customer1.save()
customer2.save()
customer3.save()

film1 = Films.new({ 'title' => 'Batman', 'price' => 25} )
film2 = Films.new({ 'title' => 'Superman', 'price' => 30 })
film3 = Films.new({ 'title' => 'Wonder Woman', 'price' => 40 })

film1.save()
film2.save()
film3.save()

ticket1 = Tickets.new({ 'customers_id' => customer1.id, 'films_id' => film1.id })
ticket2 = Tickets.new({ 'customers_id' => customer2.id, 'films_id' => film2.id })
ticket3 = Tickets.new({ 'customers_id' => customer3.id, 'films_id' => film2.id })
ticket4 = Tickets.new({ 'customers_id' => customer1.id, 'films_id' => film3.id })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()

binding.pry
nil
