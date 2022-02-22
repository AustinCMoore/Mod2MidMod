class MovieActorsController < ApplicationController

  def new #Definitely room to improve this
    @new_actor = Actor.find_by(params[:query])
    @current_movie = Movie.find(params[:id])
    @new_movie_actor = MovieActor.create!(actor_id: @new_actor.ids.first, movie_id: @current_movie.id)
    redirect_to "/movies/#{@current_movie.id}"
  end
end
