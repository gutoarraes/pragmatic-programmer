class MoviesController < ApplicationController

    before_action :require_signin, except: [:show, :index]

    before_action :require_admin?, except: [:show, :index]

    before_action :set_movie, only: [:show, :edit, :update, :destroy]

    def index
        case params[:filter]
        when "upcoming"
            @movies = Movie.upcoming
        when "recent"
            @movies = Movie.recent
        else
            @movies = Movie.released
        end
    end

    def show
        @fans = @movie.fans
        @genres = @movie.genre.order(:name)
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end

    def edit
    end

    def update
        if @movie.update(movie_params)
            redirect_to @movie, notice: 'Movie successfully updated'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def new
       @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            flash[:notice] = 'Movie successfully created'
            redirect_to @movie
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = 'Movie successfully deleted'
        redirect_to movies_url, status: :see_other
    end

    private

    def movie_params
        movie_params = params.require(:movie).permit!
    end

    def set_movie
        @movie = Movie.find_by(slug: params[:id])
    end
end
