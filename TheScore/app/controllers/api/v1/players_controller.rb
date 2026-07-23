require './lib/players_csv_serializer'

module API
  module V1
    class PlayersController < ApplicationController
      # layout API renders raw JSON
      layout 'api'

      # We only support JSON and CSV formats
      respond_to :json, :csv

      # prepares the array of Player and handles sorting and filtering logic
      before_action :set_players, only: [:index]

      # GET /api/v1/players
      # GET /api/v1/players.json
      # GET /api/v1/players.csv
      def index
        respond_to do |format|
          # Generate a CSV and send data to client
          format.csv do
            csv = PlayersCSVSerializer.new(@players).get_csv
            send_players_csv(csv)
          end

          # Generate a JSON response and paginates
          format.json do
            @players_count = @players.count
            @players_per_page = 50
            @players = @players.page(params[:page]).per(@players_per_page)
          end
        end
      end

      private

      #
      def set_players
        # Start with all players
        @players = Player.all

        # filter players if `filter` param is given
        if !filter_param.blank?
          @players = @players.where("player ILIKE '%#{filter_param}%'")
        end

        # sort players if param is given
        if !sort_param.blank? && !sort_direction_param.blank?
          @players = @players.order(sort_param => sort_direction_param)
        end
      end

      def send_players_csv(csv)
        send_data csv, type: 'text/csv; charset=utf-8; header=present', disposition: 'attachment; filename=players.csv'
      end

      def filter_param
        # Filter everything except "loosely" legal character names.
        #   Assuming we might find characters such as `, - or even _.
        #   Numbers are allowed even though it is unlikely, they don't hurt.
        #
        # Transliterate is used to convert accented letters
        #   (double single quotes to escape for postgre)
        if !params[:filter].blank?
          I18n.transliterate(params[:filter]).gsub(/([^[A-Za-z]|[0-9]|'|-|_|\s|.])/, '').gsub("'","''")
        else
          nil
        end
      end

      def sort_param
        white_listed = [
          "player", "team", "position", "rushing_attempts",
          "rushing_attempts_per_game", "total_rushing_yards",
          "rushing_average_yards_per_attempt", "rushing_yards_per_game",
          "touchdowns", "longest_rush", 'longest_rush_has_touchdown',
          "rushing_first_downs", "rushing_first_down_percentage",
          "rushing_twenty_or_more_yards_each",
          "rushing_forty_or_more_yards_each", "rushing_fumbles"
        ]

        sort = params[:sort]
        if white_listed.include? sort
          sort
        else
          nil
        end
      end

      def sort_direction_param
        white_listed = ['ASC', 'DESC']

        sort_direction = params[:sort_direction]
        if white_listed.include? sort_direction
          sort_direction
        else
          nil
        end
      end

    end
  end
end
