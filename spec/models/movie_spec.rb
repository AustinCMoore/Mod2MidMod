require 'rails_helper'

RSpec.describe Movie do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :creation_year }
    it { should validate_presence_of :genre }
  end

  describe 'relationships' do
    it { should have_many(:movie_actors) }
    it { should have_many(:actors).through(:movie_actors) }
    it { should belong_to :studio }
  end

  describe 'instance methods' do
    it "orders from youngest to oldest" do
      studio_1 = Studio.create!(name: "Turing Entertainment", location: "Denver")

      movie_1 = studio_1.movies.create!(title: "You know OOP?", creation_year: 2015, genre: 'Object Oriented')
      movie_2 = studio_1.movies.create!(title: "TDD and me", creation_year: 2016, genre: 'Test Driven Development')
      movie_3 = studio_1.movies.create!(title: "Goodbye's and API's", creation_year: 2017, genre: 'Application Programming Interface')

      actor_1 = Actor.create!(name: 'Austin Moore', age: 27)
      actor_2 = Actor.create!(name: 'Noel Sitnick', age: 26)
      actor_3 = Actor.create!(name: 'Mike Dao', age: 25) #bonus points?

      @movie_actor_1 = MovieActor.create!(actor_id: actor_1.id, movie_id: movie_1.id)
      @movie_actor_2 = MovieActor.create!(actor_id: actor_1.id, movie_id: movie_2.id)
      @movie_actor_3 = MovieActor.create!(actor_id: actor_1.id, movie_id: movie_3.id)
      @movie_actor_4 = MovieActor.create!(actor_id: actor_2.id, movie_id: movie_1.id)
      @movie_actor_5 = MovieActor.create!(actor_id: actor_2.id, movie_id: movie_2.id)
      @movie_actor_6 = MovieActor.create!(actor_id: actor_3.id, movie_id: movie_1.id)

      expect(movie_1.order_from_youngest).to eq([actor_3, actor_2, actor_1])
    end

    it "knows its actors average age" do
      studio_1 = Studio.create!(name: "Turing Entertainment", location: "Denver")

      movie_1 = studio_1.movies.create!(title: "You know OOP?", creation_year: 2015, genre: 'Object Oriented')
      movie_2 = studio_1.movies.create!(title: "TDD and me", creation_year: 2016, genre: 'Test Driven Development')
      movie_3 = studio_1.movies.create!(title: "Goodbye's and API's", creation_year: 2017, genre: 'Application Programming Interface')

      actor_1 = Actor.create!(name: 'Austin Moore', age: 27)
      actor_2 = Actor.create!(name: 'Noel Sitnick', age: 26)
      actor_3 = Actor.create!(name: 'Mike Dao', age: 25) #bonus points?

      @movie_actor_1 = MovieActor.create!(actor_id: actor_1.id, movie_id: movie_1.id)
      @movie_actor_2 = MovieActor.create!(actor_id: actor_1.id, movie_id: movie_2.id)
      @movie_actor_3 = MovieActor.create!(actor_id: actor_1.id, movie_id: movie_3.id)
      @movie_actor_4 = MovieActor.create!(actor_id: actor_2.id, movie_id: movie_1.id)
      @movie_actor_5 = MovieActor.create!(actor_id: actor_2.id, movie_id: movie_2.id)
      @movie_actor_6 = MovieActor.create!(actor_id: actor_3.id, movie_id: movie_1.id)

      expect(movie_2.avg_age).to eq(26.5)
    end
  end
end
