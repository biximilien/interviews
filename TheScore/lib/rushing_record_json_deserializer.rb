require 'json'

class RushingRecordJSONDeserializer
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def import
    players = []
    players_data = JSON.parse(File.read(@filename))
    players_data.each do |player|
      players << {
        player: player['Player'],
        team: player['Team'],
        position: player['Pos'],
        rushing_attempts: player['Att'],
        rushing_attempts_per_game: rushing_attempts_per_game(player['Att/G']),
        total_rushing_yards: player['Yds'],
        rushing_average_yards_per_attempt: player['Avg'],
        rushing_yards_per_game: player['Yds/G'],
        touchdowns: player['TD'],
        longest_rush: longest_rush(player['Lng']),
        longest_rush_has_touchdown: longest_rush_has_touchdown(player['Lng']),
        rushing_first_downs: player['1st'],
        rushing_first_down_percentage: BigDecimal(player['1st%'], 5) / BigDecimal(100, 5),
        rushing_twenty_or_more_yards_each: player['20+'],
        rushing_forty_or_more_yards_each: player['40+'],
        rushing_fumbles: player['FUM']
      }
    end

    # Create records
    Player.create!(players)
  end

  private

  #
  def rushing_attempts_per_game(attg)
    BigDecimal(attg, 2)
  end

  def longest_rush(lng)
    lng.to_i
  end

  # parses the value to find if it contains a `T` and returns true or false
  def longest_rush_has_touchdown(lng)
    return false if lng.kind_of? Numeric
    lng.include?('T')
  end

end
