require "rails_helper"

RSpec.describe RecipeIngredientsController, :cat => :controller do
  let(:valid_params) do
    {
      ingredient_id: 1,
      recipe_id: 1,
      modify: true,
      quantity: 1,
      measure: 100
    }
  end

  let(:valid_update_params) do
    {
      quantity: 100,
      measure: "ml"
    }
  end

  let(:invalid_params) do
    {
      ingredient_id: "banana",
      recipe_id: 1,
      modify: true,
      quantity: 1,
      measure: 100
    }
  end

  setup do
    create(:menu, id: 1)
    create(:menu_category, id: 1)
    create(:meal, id: 1)
    create(:ingredient, id: 1)
    create(:recipe, id: 1)
  end

  describe "#index" do
    it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      response.should render_template :index
    end

    context "We have RecipeIngredients" do
      it "has a list of RecipeIngredients", :aggregate_failures do
        create_list(:recipe_ingredient, 3)

        expect(RecipeIngredient.last.ingredient_id).to eq(1)
        expect(RecipeIngredient.all.size).to eq(3)
      end

      it "we have no RecipeIngredients" do
        get :index

        expect(RecipeIngredient.all.size).to eq(0)
      end
    end

    describe "#show" do
      it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
        create(:recipe_ingredient)
        get :show, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :show
      end

      context "we have a RecipeIngredient" do
        it "shows the right RecipeIngredient", :aggregate_failures do
          create(:recipe_ingredient)
          get :show, params: { id: 1 }

          expect(RecipeIngredient.all.size).to eq(1)
          expect(RecipeIngredient.last.id).to eq(1)
          expect(RecipeIngredient.last.id).not_to eq(7)
          expect(RecipeIngredient.last.ingredient_id).to eq(1)
        end
      end

      context "the RecipeIngredient does not exist" do
        it "does not load the RecipeIngredient" do
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
        create(:recipe_ingredient)
        get :edit, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :edit
      end

      it "redirects to the correct page" do
        create(:recipe_ingredient)
        put :update, params: { :recipe_ingredient => valid_update_params, :id => 1 }
        expect(response).to have_http_status(302)
        response.should redirect_to("/recipe_ingredients/1")
      end
    end

    describe "#create" do
      context "we pass the id of an existing ingredient" do
        it "creates a new RecipeIngredient", :aggregate_failures do
          expect{
            post :create, params: { :recipe_ingredient => valid_params }
          }.to change{RecipeIngredient.count}.by(1)
          expect(RecipeIngredient.last.ingredient_id).to eq(1)
          expect(RecipeIngredient.last.recipe_id).to eq(1)
        end

        it "redirects to the correct page", :aggregate_failures do
          post :create, params: { :recipe_ingredient => valid_params }
          response.code.should == "302"
          response.should redirect_to("/recipes/1")
        end
      end

      context "we don't pass the id of an existing ingredient" do
        it "creates a new RecipeIngredient and a new ingredient", :aggregate_failures do
          expect{
            post :create, params: { :recipe_ingredient => valid_params }
          }.to change{RecipeIngredient.count}.by(1)
          expect(RecipeIngredient.last.ingredient_id).to eq(1)
          expect(RecipeIngredient.last.recipe_id).to eq(1)
        end

        it "redirects to the correct page", :aggregate_failures do
          post :create, params: { :recipe_ingredient => valid_params }
          response.code.should == "302"
          response.should redirect_to("/recipes/1")
        end
      end

      it "doesn't create a new RecipeIngredient with invalid params", :aggregate_failures do
        expect{
          post :create, params: { :recipe_ingredient => invalid_params }
        }.to change{RecipeIngredient.count}.by(0)
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :recipe_ingredient => invalid_params }
        response.code.should == "302"
        response.should redirect_to("/recipes/1")
      end
    end

    describe "#update" do
      before(:each) do
        create(:recipe_ingredient)
      end

      it "updates the correct RecipeIngredient", :aggregate_failures do
        put :update, params: { id: 1, :recipe_ingredient => valid_update_params }
        expect(RecipeIngredient.last.id).to eq(1)
        expect(RecipeIngredient.last.ingredient_id).to eq(1)
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :recipe_ingredient => valid_update_params }
        response.code.should == "302"
        response.should redirect_to("/recipe_ingredients/1")
        end

      it "doesn't update RecipeIngredient with invalid params", :aggregate_failures do
        put :update, params: { id: 1, :recipe_ingredient => invalid_params }
        expect(RecipeIngredient.last.id).to eq(1)
        expect(RecipeIngredient.last.ingredient_id).to eq(1)
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :recipe_ingredient => invalid_params }
        response.code.should == "200"
        response.should render_template(:edit)
      end
    end

    describe "#destroy" do
      before(:each) do
        create_list(:recipe_ingredient, 2)
      end

      context "we the correct RecipeIngredient" do
        it "destroys the correct RecipeIngredient", :aggregate_failures do
          expect{ post :destroy, params: { :id => 1 } }.to change{ RecipeIngredient.all.size }.by(-1)
          expect(RecipeIngredient.last.id).to eq(2)
        end

        it "redirects to the correct page", :aggregate_failures do
           post :destroy, params: { id: 1 }
           response.code.should == "302"
            response.should redirect_to("/recipe_ingredients/1")
        end
      end
      context "we don't have a RecipeIngredient", :aggregate_failures do
        it "destroys nothing" do
          expect{ post :destroy, params: { :id => 7 } }.to raise_exception(ActiveRecord::RecordNotFound)
          expect(RecipeIngredient.all.size).to eq(2)
          expect(RecipeIngredient.first.id).to eq(1)
          expect(RecipeIngredient.last.id).to eq(2)
        end
      end
    end
  end
end
