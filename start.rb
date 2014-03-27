require './scanner.rb'


# Scanner.new('##..')
def metoda
  yield
  yield
end

metoda do
  puts "bombs"
end