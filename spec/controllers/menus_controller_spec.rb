require "rails_helper"

RSpec.describe MenusController, :cat => :controller do
  let(:valid_params) do
    {
      name: "name",
      description: "description",
      cat: "cat"
    }
  end

  let(:valid_update_params) do
    {
      name: "new name",
      description: "new description",
      cat: "new cat"
    }
  end

  let(:invalid_params) do
    {
      name: nil,
    }
  end

  describe "#index" do
    it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      response.should render_template :index
    end

    context "We have menus" do
      it "has a list of menus", :aggregate_failures do
        create_list(:menu, 3)

        expect(Menu.last.name).to eq("name")
        expect(Menu.all.size).to eq(3)
      end

      it "we have no menus" do
        get :index

        expect(Menu.all.size).to eq(0)
      end
    end

    describe "#show" do
      it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
        create(:menu)
        get :show, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :show
      end

      context "we have a menu" do
        it "shows the right menu", :aggregate_failures do
          create(:menu)
          get :show, params: { id: 1 }

          expect(Menu.all.size).to eq(1)
          expect(Menu.last.id).to eq(1)
          expect(Menu.last.id).not_to eq(7)
          expect(Menu.last.name).to eq("name")
        end
      end

      context "the menu does not exist" do
        it "does not load the menu" do
          expect(get: "/show/7").not_to be_routable
        end
      end
    end

    describe "#new" do
      it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
        get :new

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :new
      end
    end

    describe "#edit" do
      it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
        create(:menu)
        get :edit, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :edit
      end

      it "redirects to the correct page" do
        create(:menu)
        put :update, params: { :menu => valid_update_params, :id => 1 }
        expect(response).to have_http_status(302)
        response.should redirect_to("/menus/1")
      end
    end

    describe "#create" do
      it "creates a new menu", :aggregate_failures do
        expect{
          post :create, params: { :menu => valid_params }
        }.to change{Menu.count}.by(1)
        expect(Menu.last.name).to eq("name")
        expect(Menu.last.description).to eq("description")
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :menu => valid_params }
        response.code.should == "302"
        response.should redirect_to("/menus/1")
      end

      it "doesn't create a new menu with invalid params", :aggregate_failures do
        expect{
          post :create, params: { :menu => invalid_params }
        }.to change{Menu.count}.by(0)
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :menu => invalid_params }
        response.code.should == "200"
        response.should render_template(:new)
      end
    end

    describe "#update" do
      before(:each) do
        create(:menu)
      end

      it "updates the correct menu", :aggregate_failures do
        put :update, params: { id: 1, :menu => valid_update_params }
        expect(Menu.last.id).to eq(1)
        expect(Menu.last.name).to eq("new name")
        expect(Menu.last.description).to eq("new description")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :menu => valid_update_params }
        response.code.should == "302"
        response.should redirect_to("/menus/1")
        end

      it "doesn't update menu with invalid params", :aggregate_failures do
        put :update, params: { id: 1, :menu => invalid_params }
        expect(Menu.last.id).to eq(1)
        expect(Menu.last.name).to eq("name")
        expect(Menu.last.description).to eq("description")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :menu => invalid_params }
        response.code.should == "200"
        response.should render_template(:edit)
      end
    end

    describe "#destroy" do
      before(:each) do
        create_list(:menu, 2)
      end

      context "we the correct menu" do
        it "destroys the correct menu", :aggregate_failures do
          expect{ post :destroy, params: { :id => 1 } }.to change{ Menu.all.size }.by(-1)
          expect(Menu.last.id).to eq(2)
        end

        it "redirects to the correct page", :aggregate_failures do
           post :destroy, params: { id: 1 }
           response.code.should == "302"
            response.should redirect_to("/menus")
        end
      end
      context "we don't have a menu", :aggregate_failures do
        it "destroys nothing" do
          expect{ post :destroy, params: { :id => 7 } }.to raise_exception(ActiveRecord::RecordNotFound)
          expect(Menu.all.size).to eq(2)
          expect(Menu.first.id).to eq(1)
          expect(Menu.last.id).to eq(2)
        end
      end
    end
  end
end
