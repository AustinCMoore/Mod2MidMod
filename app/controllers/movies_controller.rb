class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @ordered_actors = @movie.order_from_youngest
  end
end
