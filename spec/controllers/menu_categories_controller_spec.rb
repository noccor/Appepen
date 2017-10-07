require "rails_helper"

RSpec.describe MenuCategoriesController, :cat => :controller do

  let(:valid_params) do
    {
      name: "name",
      description: "description",
      menu_category_id: 1
    }
  end

  let(:valid_update_params) do
    {
      name: "new name",
      description: "new description",
      menu_category_id: 1
    }
  end

  let(:invalid_params) do
    {
      name: nil,
    }
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
        create(:menu_category)
        get :edit, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :edit
      end

      it "redirects to the correct page" do
        create(:menu_category)
        put :update, params: { :menu_category => valid_update_params, :id => 1 }
        expect(response).to have_http_status(302)
        response.should redirect_to("/menu_categories/1")
      end
    end

    describe "#create" do
      it "creates a new menu_category", :aggregate_failures do
        expect{
          post :create, params: { :menu_category => valid_params }
        }.to change{MenuCategory.count}.by(1)
        expect(MenuCategory.last.name).to eq("name")
        expect(MenuCategory.last.description).to eq("description")
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :menu_category => valid_params }
        response.code.should == "302"
        response.should redirect_to("/menu_categories/1")
      end

      it "doesn't create a new menu_category with invalid params", :aggregate_failures do
        expect{
          post :create, params: { :menu_category => invalid_params }
        }.to change{MenuCategory.count}.by(0)
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :menu_category => invalid_params }
        response.code.should == "200"
        response.should render_template(:new)
      end
    end

    describe "#update" do
      before(:each) do
        create(:menu_category)
      end

      it "updates the correct menu_category", :aggregate_failures do
        put :update, params: { id: 1, :menu_category => valid_update_params }
        expect(MenuCategory.last.id).to eq(1)
        expect(MenuCategory.last.name).to eq("new name")
        expect(MenuCategory.last.description).to eq("new description")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :menu_category => valid_update_params }
        response.code.should == "302"
        response.should redirect_to("/menu_categories/1")
        end

      it "doesn't update menu_category with invalid params", :aggregate_failures do
        put :update, params: { id: 1, :menu_category => invalid_params }
        expect(MenuCategory.last.id).to eq(1)
        expect(MenuCategory.last.name).to eq("name")
        expect(MenuCategory.last.description).to eq("description")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :menu_category => invalid_params }
        response.code.should == "200"
        response.should render_template(:edit)
      end
    end

    describe "#destroy" do
      before(:each) do
        create_list(:menu_category, 2)
      end

      context "we the correct menu_category" do
        it "destroys the correct menu_category", :aggregate_failures do
          expect{ post :destroy, params: { :id => 1 } }.to change{ MenuCategory.all.size }.by(-1)
          expect(MenuCategory.last.id).to eq(2)
        end

        it "redirects to the correct page", :aggregate_failures do
           post :destroy, params: { id: 1 }
           response.code.should == "302"
            response.should redirect_to("/menu_categories")
        end
      end
      context "we don't have a menu_category", :aggregate_failures do
        it "destroys nothing" do
          expect{ post :destroy, params: { :id => 7 } }.to raise_exception(ActiveRecord::RecordNotFound)
          expect(MenuCategory.all.size).to eq(2)
          expect(MenuCategory.first.id).to eq(1)
          expect(MenuCategory.last.id).to eq(2)
        end
      end
    end
  end
end
