class AddEmbedUrlToVideo < ActiveRecord::Migration[7.2]
  def change
    add_column :videos, :embed_url, :string
  end
end
