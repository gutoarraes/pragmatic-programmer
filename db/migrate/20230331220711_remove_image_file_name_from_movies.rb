class RemoveImageFileNameFromMovies < ActiveRecord::Migration[7.0]
  def change
    remove_column :movies, :ImageFileName, :string
  end
end
