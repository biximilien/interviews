module API
  class PokemonsController < ApplicationController

    respond_to :json

    before_action :set_pokemon, only: [:show, :update, :destroy]

    def index
      if params[:q]
        @pokemons = Pokemon.search(params[:q]).records
      else
        @pokemons = Pokemon.all
      end
      @paged_pokemons = @pokemons.page(params[:page])
      @total_pages = @paged_pokemons.total_pages
      @current_page = @paged_pokemons.current_page
      @next_page = @paged_pokemons.next_page
      @prev_page = @paged_pokemons.prev_page
      respond_with :api, @pokemons
    end

    def show
      respond_with :api, @pokemon
    end

    def create
      @pokemon = Pokemon.create(pokemon_params)
      respond_with :api, @pokemon
    end

    def update
      @pokemon.update(pokemon_params)
      respond_with :api, @pokemon
    end

    def destroy
      @pokemon.destroy
      head :no_content
    end

    private

      def set_pokemon
        @pokemon = Pokemon.find(params[:id])
      end

      def pokemon_params
        params.require(:pokemon).permit(:number, :name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
      end

  end
end
