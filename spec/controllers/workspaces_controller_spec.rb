require 'rails_helper'

RSpec.describe WorkspacesController, type: :controller do
  let(:subject) { response }

  describe 'GET #index' do
    let!(:workspaces) { create_list :workspace, 5 }
    let(:perform) { get :index }
    before { perform }

    it { should be_successful }
    it { expect(assigns(:workspaces)).to eq(workspaces) }
  end

  describe 'GET #show' do
    before { perform }

    context 'OK' do
      let(:workspace) { create :workspace }
      let(:perform) { get :show, id: workspace.id, format: :json }

      it { should be_successful }
      it { expect(assigns(:workspace)).to eq(workspace) }

      it 'returns proper workspace json payload' do
        decoded_body = JSON.parse response.body
        expect(decoded_body).to eq({
          "workspace" => {
            "id" => workspace.id,
            "name" => workspace.name
          }
        })
      end
    end

    context 'not found' do
      let(:perform) { get :show, id: 'bah', format: :json }

      it { should be_not_found }
      it { subject.body.should be_empty }

      it 'doesnt assign @workspace' do
        expect(assigns(:workspace)).to be_nil
      end
    end
  end

  describe 'POST #create' do
    let(:perform) { post :create, params }
    let(:params) {
      {
        workspace: { name: 'Test Workspace' }
      }
    }

    it { expect{perform}.to change(Workspace, :count).by(1) }

    describe 'response' do
      before { perform }

      it { should be_successful }
      it { expect(assigns(:workspace)).to be }

      it 'returns proper workspace json payload' do
        decoded_body = JSON.parse response.body
        expect(decoded_body).to eq({
          "workspace" => {
            "id" => assigns(:workspace).id,
            "name" => 'Test Workspace'
          }
        })
      end
    end
  end

  describe 'PUT #update' do
    pending
  end

  describe 'DELETE #destroy' do
    context 'OK' do
      let!(:workspace) { create :workspace }
      let(:perform) { delete :destroy, id: workspace.id }

      it { expect{perform}.to change(Workspace, :count).by(-1) }

      describe 'response' do
        before { perform }

        it { should be_successful }
        it { subject.body.should be_empty }

        it 'assigns @workspace' do
          expect(assigns(:workspace)).to eq(workspace)
        end
      end
    end

    context 'not found' do
      let(:perform) { delete :destroy, id: 'bah'}

      it { expect{perform}.not_to change(Workspace, :count) }

      describe 'response' do
        before { perform }

        it { should be_not_found }
        it { subject.body.should be_empty }

        it 'doesnt assign @workspace' do
          expect(assigns(:workspace)).to be_nil
        end
      end
    end
  end
end
