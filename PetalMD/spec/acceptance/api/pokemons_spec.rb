require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Pokemons" do

  explanation "Pokemons resource"

  get "/api/pokemons" do
    parameter :page, 'Page to view'
    parameter :q, 'Search query'

    example "Listing Pokemons" do
      do_request
      expect(status).to eq 200
    end

    example_request "Listing Pokemons on page 7", page: 7 do
      expect(status).to eq 200
    end

    example_request "Listing Pokemons by search query", q: 'Pikachu' do
      expect(status).to eq 200
    end
  end

  get "/api/pokemons/1" do
    parameter :id, 'Pokemon id'

    example "Retrieve a Pokemon by id" do
      do_request
      expect(status).to eq 200
    end
  end

  post "/api/pokemons" do
    let (:pokemon) {
      {
        number: '722',
        name: 'Pikablu',
        type_1: 'Water',
        type_2: 'Electric',
        total: 600,
        hp: 100,
        attack: 100,
        defense: 100,
        sp_atk: 100,
        sp_def: 100,
        speed: 100,
        generation: 1,
        legendary: true
      }
    }

    with_options scope: :pokemon, required: true do
      parameter :number,     "Pokemon's Number",     type: :integer
      parameter :name,       "Pokemon's Name",       type: :string
      parameter :type_1,     "Pokemon's Type 1",     type: :string
      parameter :type_2,     "Pokemon's Type 2",     type: :string, required: false
      parameter :total,      "Pokemon's total",      type: :integer
      parameter :hp,         "Pokemon's HP",         type: :integer
      parameter :attack,     "Pokemon's Attack",     type: :integer
      parameter :defense,    "Pokemon's Defense",    type: :integer
      parameter :sp_atk,     "Pokemon's Sp. Atk.",   type: :integer
      parameter :sp_def,     "Pokemon's Sp. Def.",   type: :integer
      parameter :speed,      "Pokemon's Speed",      type: :integer
      parameter :generation, "Pokemon's Generation", type: :integer
      parameter :legendary,  "Pokemon is legendary", type: :boolean
    end

    example "Creating a pokemon" do
      do_request(pokemon: pokemon)
      expect(status).to eq(201)
    end
  end

  put "/api/pokemons/1" do
    let (:pokemon) {
      {
        name: 'Bubasaur'
      }
    }

    with_options scope: :pokemon, required: false do
      parameter :number,     "Pokemon's Number",     type: :integer, required: true
      parameter :name,       "Pokemon's Name",       type: :string
      parameter :type_1,     "Pokemon's Type 1",     type: :string
      parameter :type_2,     "Pokemon's Type 2",     type: :string
      parameter :total,      "Pokemon's total",      type: :integer
      parameter :hp,         "Pokemon's HP",         type: :integer
      parameter :attack,     "Pokemon's Attack",     type: :integer
      parameter :defense,    "Pokemon's Defense",    type: :integer
      parameter :sp_atk,     "Pokemon's Sp. Atk.",   type: :integer
      parameter :sp_def,     "Pokemon's Sp. Def.",   type: :integer
      parameter :speed,      "Pokemon's Speed",      type: :integer
      parameter :generation, "Pokemon's Generation", type: :integer
      parameter :legendary,  "Pokemon is legendary", type: :boolean
    end

    example "Updating a Pokemon" do
      do_request(pokemon: pokemon)
      expect(status).to eq(204)
    end
  end

  patch "/api/pokemons/1" do
    let (:pokemon) {
      {
        name: 'Babasaur'
      }
    }

    with_options scope: :pokemon, required: false do
      parameter :number,     "Pokemon's Number",     type: :integer, required: true
      parameter :name,       "Pokemon's Name",       type: :string
      parameter :type_1,     "Pokemon's Type 1",     type: :string
      parameter :type_2,     "Pokemon's Type 2",     type: :string
      parameter :total,      "Pokemon's total",      type: :integer
      parameter :hp,         "Pokemon's HP",         type: :integer
      parameter :attack,     "Pokemon's Attack",     type: :integer
      parameter :defense,    "Pokemon's Defense",    type: :integer
      parameter :sp_atk,     "Pokemon's Sp. Atk.",   type: :integer
      parameter :sp_def,     "Pokemon's Sp. Def.",   type: :integer
      parameter :speed,      "Pokemon's Speed",      type: :integer
      parameter :generation, "Pokemon's Generation", type: :integer
      parameter :legendary,  "Pokemon is legendary", type: :boolean
    end

    example "Updating a Pokemon" do
      do_request(pokemon: pokemon)
      expect(status).to eq(204)
    end
  end

  delete "/api/pokemons/151" do
    example "Deleting a Pokemon" do
      do_request
      expect(status).to eq 204
    end
  end
end
