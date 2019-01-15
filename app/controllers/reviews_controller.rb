class ReviewsController < ApplicationController
    before_action :find_review, only: [:destroy]
    before_action :authenticate_user!
    before_action :authorized_user!, only: [:destroy]

    def create
        @idea = Idea.find params[:idea_id]
        @review = Review.new review_params
        @review.idea = @idea
        @review.user = current_user
        if @review.save
            redirect_to idea_path(@idea.id)
        else
            @reviews = @idea.review.order(created_at: :desc)
            render "ideas/show"
        end
    end

    def destroy
        @review = Review.find params[:id]
          @review.destroy
          flash[:primary] = "Why delete me?"
          redirect_to idea_path(@review.idea.id)
    end

    private
    def find_review
        @review = Review.find params[:id]
    end

    def review_params
        params.require(:review).permit(:body)
    end

    def authorized_user!
        unless can?(:crud, @review)
            flash[:primary] = "No can do"
                redirect_to idea_path(@review.idea.id)
        end
    end
end
