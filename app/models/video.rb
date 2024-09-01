class Video < ApplicationRecord
  CREATE_PARAMS = %i[url]

  belongs_to :user

  validates :url, presence: true
end
