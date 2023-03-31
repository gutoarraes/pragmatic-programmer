class GenresController < ApplicationController
  belongs_to :movie
  belongs_to :genre
end
