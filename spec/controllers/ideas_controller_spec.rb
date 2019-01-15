require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    def current_user
        @current_user ||= FactoryBot.create(:user)
    end

    describe "#new" do
        context "without signed in user" do
            it "redirects to new session" do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end
            it "displays the flash message" do
                get(:new)
                expect(flash[:danger]).to be
            end
        end


        context "with signed in user" do
            before do
                session[:user_id] = current_user.id
            end
            it "renders a new template" do
                get(:new)
                expect(response).to(render_template(:new))
            end
            it "creates an instance variable for an idea" do
                get(:new)
                expect(assigns(:idea)).to(be_a_new(Idea))
                
            end
        end 
    end

    describe "#create" do
        def valid_idea
            post(:create, params: { idea: FactoryBot.attributes_for(:idea)})
            
        end
        context "without user signed in" do
            it "redirects to new session" do
                valid_idea
                expect(response).to redirect_to(new_session_path)
            end
            it "displays the flash message" do
                get(:new)
                expect(flash[:danger]).to be
            end
        end

        context "with user signed in" do
            before do
                session[:user_id] = current_user.id
            end
            context "with valid parameters" do
                it "creates a new idea" do
                    count_before = Idea.count 
                    valid_idea
                    count_after = Idea.count
                    expect(count_after).to eq(count_before + 1)
                end

                it "redirects to index page" do
                    valid_idea
                    idea = Idea.last
                    expect(response).to redirect_to(ideas_path)
                end

                it "associates the idea with the current user" do
                    valid_idea
                    idea = Idea.last
                    expect(idea.user).to eq(current_user)
                end
            end

            context "with invalid parameters" do
                def invalid_idea
                    post(:create, params: { idea: FactoryBot.attributes_for(:idea, title: nil)})
                end
                
                it "cannot create a idea" do
                    count_before = Idea.count
                    invalid_idea
                    count_after = Idea.count
                    expect(count_before).to eq(count_after)
                end

                it "renders new page" do
                    invalid_idea
                    expect(response).to render_template(:new)
                end
                it "assigns an invalid idea as an instance variable." do
                    invalid_idea
                    expect(assigns(:idea)).to be_a(Idea)
                    expect(assigns(:idea).valid?).to be(false)
                end
            end
        end
    end

end
