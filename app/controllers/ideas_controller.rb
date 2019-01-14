class IdeasController < ApplicationController
    before_action :find_idea, only: [:show, :destroy, :edit, :update]
    before_action :authenticate_user!, except: [:show, :index]

    def index
        @ideas = Idea.all.order(created_at: :desc)
    end

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new idea_params
        # @idea.user = current_user
        if @idea.save
            redirect_to ideas_path
        else
            render :new
        end
    end

    def show
        # @idea = Idea.find params[:id]
        @reviews = @idea.reviews.order(created_at: :desc)
        @review = Review.new
    end

    def destroy
        # @idea = Idea.find params[:id]
        @idea.destroy
        redirect_to ideas_path
    end

    def edit
        # @idea = Idea.find params[:id]
    end

    def update
        # @idea = Idea.find params[:id]
        if @idea.update idea_params
            redirect_to idea_path(@idea.id)
        else 
            render :edit
        end
    end



    private 

    def idea_params
        params.require(:idea).permit(:title, :body)
    end

    def find_idea
        @idea = Idea.find params[:id]
    end
end
