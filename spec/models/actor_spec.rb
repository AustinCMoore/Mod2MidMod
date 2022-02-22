require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
  end

  describe 'relationships' do
    it { should have_many(:movie_actors) }
    it { should have_many(:movies).through(:movie_actors) }
  end

  describe 'class methods' do
    it "can find an Actor by its name" do
      actor_1 = Actor.create!(name: 'Austin Moore', age: 27)
      actor_2 = Actor.create!(name: 'Noel Sitnick', age: 26)
      actor_3 = Actor.create!(name: 'Mike Dao', age: 25)
      expect(Actor.find_by('Mike Dao')).to eq([actor_3])
    end
  end
end
