require 'rails_helper'

RSpec.describe Web::Users::TasksController, type: :controller do

  let(:user)  { create(:user) }
  let(:user2) { create(:user) }
  let(:task)  { create(:task, user: user) }
  let(:task2) { create(:task, user: user2) }

  before { sign_in(user) }

  describe "GET #index" do
    before { 
      task
      get :index, params: { user_id: current_user.id }
    }

    it "populates an array of tasks" do
      expect(assigns(:tasks)).to match_array(current_user.tasks)
    end

    it "renders index view" do
      expect(response).to render_template :index
    end

  end

  describe "GET #show" do
    before { get :show, params: { user_id: user.id, id: task.id } }

    it "assigns the requested task to @task" do
      expect(assigns(:task)).to eq(task)
    end

    it "renders show view" do
      expect(response).to render_template :show
    end

  end

  describe "GET #new" do
    before { get :new , params: { user_id: user.id }}

    it "assigns a new task to @task" do
      expect(assigns(:task)).to be_a_new(Task)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end

  end

  describe "POST #create" do

    context "with valid attributes" do
      before { 
        task2 = build(:task)
        post :create, params: {user_id: user.id, task: attributes_for(:task) }
      }

      it "assigns task to user" do
        expect(assigns(:task).user_id).to eq current_user.id
      end

      it "redirects to show view" do
        expect(response).to redirect_to user_task_path(user_id: current_user.id, id: assigns(:task).id)
      end
    end

    context "with invalid attributes" do

      it 'does not save the task' do
        expect { post :create, params: { user_id: user.id, task: attributes_for(:invalid_task) } }.to_not change(Task, :count)
      end

      it 're-renders new view' do
        post :create, params: { user_id: user.id, task: attributes_for(:invalid_task) }
        expect(response).to render_template :new
      end
    end


  end

  describe "GET #edit" do
    before { get :edit , params: { user_id: user.id, id: task.id }}

    it "assigns the requested task to @task" do
      expect(assigns(:task)).to eq(task)
    end

    it "renders new view" do
      expect(response).to render_template :edit
    end

  end

  describe "POST #update" do
    context 'valid attributes' do
      it 'assings the requested task to @task' do
        patch :update, params: { id: task, user_id: current_user.id, task: attributes_for(:task) }
        expect(assigns(:task)).to eq task
      end
      it 'changes task attributes' do
        patch :update, params: { id: task, user_id: current_user.id, task: {name: '111'} }
        task.reload
        expect(task.name).to eq '111'
      end
      it 'redirects to the updated task' do
        patch :update, params: { id: task, user_id: current_user.id, task: attributes_for(:task) }
        expect(response).to redirect_to user_task_path(id: task, user_id: current_user.id)
      end
    end

    context 'invalid attributes' do
      before do
        patch :update, params: { id: task, task: { name: nil }, user_id: current_user.id }
      end
      it 'does not change task attributes' do
        task.reload
        expect(task.name).to_not eq nil
      end
      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:task1) { create(:task, user: current_user) }
    it 'deletes task' do
      expect { delete :destroy, params: {user_id: current_user.id, id: task1} }.to change(Task, :count).by(-1)
    end
    it 'redirect to index view' do
      delete :destroy, params: {user_id: current_user.id, id: task1}
      expect(response).to redirect_to user_tasks_path
    end
    it 'partner cant delete another partner task' do
      task2
      expect { delete :destroy, params: {user_id: current_user.id, id: task2} }.to_not change(Task, :count)
    end
  end


end
