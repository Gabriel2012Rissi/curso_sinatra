cars = [
  {
    brand: 'Ford',
    model: 'Mustang',
    year: 2019,
    price: 200000
  },
  {
    brand: 'Chevrolet',
    model: 'Camaro',
    year: 2017,
    price: 197778
  },
  {
    brand: 'Dodge',
    model: 'Challenger',
    year: 2016,
    price: 187654
  },
]

cars.each { |car| Car.create(car) }