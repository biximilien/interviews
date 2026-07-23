require 'rails_helper'

RSpec.describe NewsArticle, type: :model do
  it { should validate_uniqueness_of(:title).case_insensitive }
  it { should validate_presence_of :title }
  it { should_not allow_value('').for(:title) }
  it { should_not allow_value(nil).for(:title) }

  it { should validate_presence_of :publication_date }

  it { should validate_presence_of :author }
  it { should_not allow_value('').for(:author) }
  it { should_not allow_value(nil).for(:author) }

  it { should validate_presence_of :category }
  it { should_not allow_value('').for(:category) }
  it { should_not allow_value(nil).for(:category) }
end
