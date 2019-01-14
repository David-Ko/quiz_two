class Idea < ApplicationRecord

    validates(
        :title, presence: { message: "Title ust be present" }
    )

    validates(
        :body, presence: { message: "Body must be present" }
    )
end
