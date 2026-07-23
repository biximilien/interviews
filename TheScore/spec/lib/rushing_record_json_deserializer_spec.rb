require 'rails_helper'

RSpec.describe RushingRecordJSONDeserializer do
  describe "#new" do
    it "creates a new deserializer given a filename" do
      # it is best to try and avoid pronouncing the second `R`
      expect(RushingRecordJSONDeserializer.new('splourrgtch.json')).to \
        be_a RushingRecordJSONDeserializer
    end
  end

  describe "#import" do
    subject { RushingRecordJSONDeserializer.new('db/data/rushing.json') }
    it "imports the JSON dataset into ActiveRecord models" do
      expect{ subject.import }.to change { Player.count }.by(326)
    end
  end
end
