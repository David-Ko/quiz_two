class IdeasController < ApplicationController

    def index
        @ideas = Idea.all.order(created_at: :desc)
    end

    def new
        @idea = Idea.new
    end
end
