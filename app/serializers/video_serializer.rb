class VideoSerializer < BaseSerializer
  attributes :id, :url, :embed_url, :title, :description

  belongs_to :user, serializer: :user
end
