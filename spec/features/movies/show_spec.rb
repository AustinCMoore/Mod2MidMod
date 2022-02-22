require 'rails_helper'

RSpec.describe 'movie show page' do
  it "lists a movie's title, creation year, and genre" do
    studio_1 = Studio.create!(name: "Turing Entertainment", location: "Denver")

    movie_1 = studio_1.movies.create!(title: "You know OOP?", creation_year: 2015, genre: 'Object Oriented')
    movie_2 = studio_1.movies.create!(title: "TDD and me", creation_year: 2016, genre: 'Test Driven Development')
    movie_3 = studio_1.movies.create!(title: "Goodbye's and API's", creation_year: 2017, genre: 'Application Programming Interface')

    visit "/movies/#{movie_1.id}"

    expect(current_path).to eq("/movies/#{movie_1.id}")

    expect(page).to have_content("Movie Title: #{movie_1.title}")
    expect(page).to_not have_content("Movie Title: #{movie_2.title}")

    expect(page).to have_content("Movie Creation Year: #{movie_1.creation_year}")
    expect(page).to_not have_content("Movie Creation Year: #{movie_2.creation_year}")

    expect(page).to have_content("Movie Genre: #{movie_1.genre}")
    expect(page).to_not have_content("Movie Genre: #{movie_2.genre}")
  end

  it "lists all of a movie's actors from youngest to oldest and their avg age" do
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

    visit "/movies/#{movie_2.id}"

    expect(page).to have_content("#{actor_1.name}")
    expect(page).to have_content("#{actor_2.name}")

    expect("#{actor_2.name}").to appear_before("#{actor_1.name}")

    expect(page).to have_content("Avg Age: 26.5")
  end

  it "can add an actor to a movie" do
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

    visit "/movies/#{movie_2.id}"

    expect(page).to_not have_content("#{actor_3.name}")

    expect(page).to have_content("Add an Actor to this Movie")
    fill_in('query', with: 'Mike Dao')
    click_on('Add')

    expect(current_path).to eq("/movies/#{movie_2.id}?add=#{actor_3.name}")

    expect(page).to have_content("#{actor_3.name}")
  end
end
