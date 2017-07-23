require "rails_helper"

RSpec.describe IngredientsController, :cat => :controller do
  let(:valid_params) do
    {
      name: "bread",
      description: "bread",
      allergens: ["gluten"].to_a,
      cat: "staple",
      flavor: "savory"
    }
  end

  let(:valid_update_params) do
    {
      name: "brown bread",
      description: "brown bread",
      allergens: ["gluten"].to_a,
      cat: "staple",
      flavor: "savory"
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

    context "We have ingredients" do
      it "has a list of ingredients", :aggregate_failures do
        create_list(:ingredient, 3)

        expect(Ingredient.last.name).to eq("bread")
        expect(Ingredient.all.size).to eq(3)
      end

      it "we have no ingredients" do
        get :index

        expect(Ingredient.all.size).to eq(0)
      end
    end

    describe "#show" do
      it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
        create(:ingredient)
        get :show, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :show
      end

      context "we have a ingredient" do
        it "shows the right ingredient", :aggregate_failures do
          create(:ingredient)
          get :show, params: { id: 1 }

          expect(Ingredient.all.size).to eq(1)
          expect(Ingredient.last.id).to eq(1)
          expect(Ingredient.last.id).not_to eq(7)
          expect(Ingredient.last.name).to eq("bread")
        end
      end

      context "the ingredient does not exist" do
        it "does not load the ingredient" do
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
        create(:ingredient)
        get :edit, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :edit
      end

      it "redirects to the correct page" do
        create(:ingredient)
        put :update, params: { :ingredient => valid_update_params, :id => 1 }
        expect(response).to have_http_status(302)
        response.should redirect_to("/ingredients/1")
      end
    end

    describe "#create" do
      it "creates a new ingredient", :aggregate_failures do
        expect{
          post :create, params: { :ingredient => valid_params }
        }.to change{Ingredient.count}.by(1)
        expect(Ingredient.last.name).to eq("bread")
        expect(Ingredient.last.description).to eq("bread")
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :ingredient => valid_params }
        response.code.should == "302"
        response.should redirect_to("/ingredients/1")
      end

      it "doesn't create a new ingredient with invalid params", :aggregate_failures do
        expect{
          post :create, params: { :ingredient => invalid_params }
        }.to change{Ingredient.count}.by(0)
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :ingredient => invalid_params }
        response.code.should == "200"
        response.should render_template(:new)
      end
    end

    describe "#update" do
      before(:each) do
        create(:ingredient)
      end

      it "updates the correct ingredient", :aggregate_failures do
        put :update, params: { id: 1, :ingredient => valid_update_params }
        expect(Ingredient.last.id).to eq(1)
        expect(Ingredient.last.name).to eq("brown bread")
        expect(Ingredient.last.description).to eq("brown bread")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :ingredient => valid_update_params }
        response.code.should == "302"
        response.should redirect_to("/ingredients/1")
        end

      it "doesn't update ingredient with invalid params", :aggregate_failures do
        put :update, params: { id: 1, :ingredient => invalid_params }
        expect(Ingredient.last.id).to eq(1)
        expect(Ingredient.last.name).to eq("bread")
        expect(Ingredient.last.description).to eq("bread")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :ingredient => invalid_params }
        response.code.should == "200"
        response.should render_template(:edit)
      end
    end

    describe "#destroy" do
      before(:each) do
        create_list(:ingredient, 2)
      end

      context "we the correct ingredient" do
        it "destroys the correct ingredient", :aggregate_failures do
          expect{ post :destroy, params: { :id => 1 } }.to change{ Ingredient.all.size }.by(-1)
          expect(Ingredient.last.id).to eq(2)
        end

        it "redirects to the correct page", :aggregate_failures do
           post :destroy, params: { id: 1 }
           response.code.should == "302"
            response.should redirect_to("/ingredients")
        end
      end
      context "we don't have a ingredient", :aggregate_failures do
        it "destroys nothing" do
          expect{ post :destroy, params: { :id => 7 } }.to raise_exception(ActiveRecord::RecordNotFound)
          expect(Ingredient.all.size).to eq(2)
          expect(Ingredient.first.id).to eq(1)
          expect(Ingredient.last.id).to eq(2)
        end
      end
    end
  end
end
