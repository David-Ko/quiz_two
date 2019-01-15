class Idea < ApplicationRecord
    has_many :reviews, dependent: :destroy
    belongs_to :user

    validates(
        :title, presence: { message: "Title ust be present" }
    )

    validates(
        :body, presence: { message: "Body must be present" }
    )
end
