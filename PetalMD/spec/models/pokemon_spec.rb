require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  subject {
    Pokemon.create(
      number: 777,
      name: 'Testimon',
      type_1: 'Bug',
      hp: 100,
      attack: 100,
      defense: 100,
      sp_atk: 100,
      sp_def: 100,
      speed: 100,
      generation: 77,
      legendary: false
    )
  }

  it { should validate_presence_of :number }
  it { should validate_presence_of :name }
  it { should validate_presence_of :type_1 }
  it { should validate_presence_of :generation }

  describe ".search" do
    subject { Pokemon }
    it "searches for matching Pokemons" do
      records = subject.search('Pikachu').records
      expect(records).not_to be nil
      expect(records.first.name).to eq 'Pikachu'
    end
  end

  describe "#compute_total" do
    subject {
      Pokemon.new(
        number: 777,
        name: 'Testimon',
        type_1: 'Bug',
        hp: 100,
        attack: 100,
        defense: 100,
        sp_atk: 100,
        sp_def: 100,
        speed: 100,
        generation: 77,
        legendary: false
      )
    }

    it "sums the Pokemon's stats" do
      subject.save!
      expect(subject.total).to eq 600
    end
  end

  describe "#legendary" do
    subject {
      Pokemon.new(
        number: 777,
        name: 'Testimon',
        type_1: 'Bug',
        hp: 100,
        attack: 100,
        defense: 100,
        sp_atk: 100,
        sp_def: 100,
        speed: 100,
        generation: 77
      )
    }

    it "shoulds save 'Yes' as `true`" do
      subject.legendary = 'Yes'
      subject.save!
      expect(subject.legendary).to eq true
    end

    it "shoulds save 'No' as `false`" do
      subject.legendary = 'No'
      subject.save!
      expect(subject.legendary).to eq false
    end
  end
end
