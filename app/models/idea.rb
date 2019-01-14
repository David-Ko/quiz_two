class Idea < ApplicationRecord
    has_many :reviews, dependent: :destroy
    
    validates(
        :title, presence: { message: "Title ust be present" }
    )

    validates(
        :body, presence: { message: "Body must be present" }
    )
end
