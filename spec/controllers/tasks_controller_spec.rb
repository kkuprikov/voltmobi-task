require 'rails_helper'

RSpec.describe Users::TasksController, type: :controller do

  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before { 
    sign_in(user)
  }

  describe "GET #index" do

    it "populates an array of tasks" do
      task
      get :index, params: { user_id: current_user.id }
      expect(assigns(:tasks)).to match_array(current_user.tasks)
      expect(response).to render_template("index")
      expect(response.status).to eq(200)
    end

  end

end
