require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should_not allow_value(nil).for(:player) }
  it { should_not allow_value('').for(:player) }
  it { should validate_length_of(:player).is_at_least(1).is_at_most(120) }

  it { should validate_length_of(:position).is_at_least(1).is_at_most(2) }
  it { should_not allow_value(nil).for(:position) }
  it { should_not allow_value('').for(:position) }

  it { should validate_length_of(:team).is_at_least(1).is_at_most(3) }
  it { should_not allow_value(nil).for(:team) }
  it { should_not allow_value('').for(:team) }
end
