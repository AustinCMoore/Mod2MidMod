require 'rails_helper'

RSpec.describe 'studio index page' do
  it "lists each studio's name, location, and movie titles" do
    studio_1 = Studio.create!(name: "Turing Entertainment", location: "Denver")
    studio_2 = Studio.create!(name: "Austin's Movie Studio", location: "Laurel")
    studio_3 = Studio.create!(name: "Noel's Movie Studio", location: "Baltimore")

    movie_1 = studio_1.movies.create!(title: "You know OOP?", creation_year: 2015, genre: 'Object Oriented')
    movie_2 = studio_1.movies.create!(title: "TDD and me", creation_year: 2016, genre: 'Test Driven Development')
    movie_3 = studio_1.movies.create!(title: "Goodbye's and API's", creation_year: 2017, genre: 'Application Programming Interface')
    movie_4 = studio_2.movies.create!(title: "Awkward in HighSchool", creation_year: 2018, genre: 'Reality')
    movie_5 = studio_2.movies.create!(title: "Moving to Maryland", creation_year: 2019, genre: 'Reality')
    movie_6 = studio_3.movies.create!(title: "Loving this idiot", creation_year: 2020, genre: 'Romance')

    visit "/studios"

    expect(current_path).to eq("/studios")

    expect(page).to have_content("Studio Name: #{studio_1.name}")
    expect(page).to have_content("Studio Name: #{studio_2.name}")
    expect(page).to have_content("Studio Name: #{studio_3.name}")

    expect(page).to have_content("Studio Location: #{studio_1.location}")
    expect(page).to have_content("Studio Location: #{studio_2.location}")
    expect(page).to have_content("Studio Location: #{studio_3.location}")

    within("#studio-#{studio_1.id}") do
      expect(page).to have_content("#{movie_1.title}")
      expect(page).to have_content("#{movie_2.title}")
      expect(page).to have_content("#{movie_3.title}")
      expect(page).to_not have_content("#{movie_4.title}")
      expect(page).to_not have_content("#{movie_5.title}")
      expect(page).to_not have_content("#{movie_6.title}")
    end

    within("#studio-#{studio_2.id}") do
      expect(page).to_not have_content("#{movie_1.title}")
      expect(page).to_not have_content("#{movie_2.title}")
      expect(page).to_not have_content("#{movie_3.title}")
      expect(page).to have_content("#{movie_4.title}")
      expect(page).to have_content("#{movie_5.title}")
      expect(page).to_not have_content("#{movie_6.title}")
    end

    within("#studio-#{studio_3.id}") do
      expect(page).to_not have_content("#{movie_1.title}")
      expect(page).to_not have_content("#{movie_2.title}")
      expect(page).to_not have_content("#{movie_3.title}")
      expect(page).to_not have_content("#{movie_4.title}")
      expect(page).to_not have_content("#{movie_5.title}")
      expect(page).to have_content("#{movie_6.title}")
    end
  end

  
end
