class MoviesController < ApplicationController

    before_action :require_signin, except: [:show, :index]

    before_action :require_admin?, except: [:show, :index]

    def index
        @movies = Movie.released
    end

    def show
        @movie = Movie.find(params[:id])
        @fans = @movie.fans
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end

    def edit
        @movie = Movie.find(params[:id])
    end

    def update
        @movie = Movie.find(params[:id])
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
end
