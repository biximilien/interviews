require 'csv'

class PokemonImporter
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def run
    pokes = []
    CSV.foreach(filename, options) do |row|
      pokes << {
        number: row['#'],
        name: row['Name'],
        type_1: row['Type 1'],
        type_2: row['Type 2'],
        total: row['Total'],
        hp: row['HP'],
        attack: row['Attack'],
        defense: row['Defense'],
        sp_atk: row['Sp. Atk'],
        sp_def: row['Sp. Def'],
        speed: row['Speed'],
        generation: row['Generation'],
        legendary: !!(/True/i =~ row['Legendary'])
      }
    end
    Pokemon.create!(pokes)
  end

  protected

    def options
      {headers: :first_row}
    end

end
