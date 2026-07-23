class Player < ApplicationRecord

  # attribute aliases for convenience
  #   (some people might not like to type those long names)
  alias_attribute :name,    :player
  alias_attribute :pos,     :position
  alias_attribute :att_g,   :rushing_attempts_per_game_average
  alias_attribute :att,     :rushing_attempts
  alias_attribute :yds,     :total_rushing_yards
  alias_attribute :avg,     :rushing_average_yards_per_attempt
  alias_attribute :yds_g,   :rushing_yards_per_game
  alias_attribute :td,      :touchdowns
  alias_attribute :lng,     :longest_rush
  alias_attribute :first,   :rushing_first_downs
  alias_attribute :first_p, :rushing_first_down_percentage
  alias_attribute :twenty,  :rushing_twenty_or_more_yards_each
  alias_attribute :forty,   :rushing_forty_or_more_yards_each
  alias_attribute :fum,     :rushing_fumbles

  # Name
  #   Minimum 1 characters and maximum 100 characters
  validates :player,
    presence: true,
    allow_blank: false,
    length: { in: 1..120 }

  # Team
  #   3 characters length
  validates :team,
    presence: true,
    length: { in: 1..3 }

  # Position
  #   2 characters length
  validates :position,
    presence: true,
    length: { in: 1..2 }

  # Rushing Attempts per Game Average
  validates :rushing_attempts_per_game,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 }

end
