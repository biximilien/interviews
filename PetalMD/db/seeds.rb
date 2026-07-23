require_relative '../lib/pokemon_importer'

unless Pokemon.any?
  pokemons_data = File.join(Rails.root, 'db/data/pokemon.csv')
  importer = PokemonImporter.new(pokemons_data)
  importer.run
end
