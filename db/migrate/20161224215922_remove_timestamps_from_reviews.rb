class RemoveTimestampsFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :timestamps, :string
  end
end
