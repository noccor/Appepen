require "rails_helper"

RSpec.describe MealsController, :cat => :controller do
  before do
  create(:menu)
  end

  let(:valid_params) do
    {
      menu_id: 1,
      name: "Banana Nut",
      description: "Bananas and nuts",
      traces_of_nuts: true,
      traces_of_gluten: false,
      traces_of_lactose: false,
    }
  end

  let(:valid_update_params) do
    {
      menu_id: 1,
      name: "Updated Name",
      description: "Updated Description",
      traces_of_nuts: true,
      traces_of_gluten: false,
      traces_of_lactose: false,
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

    context "We have meals" do
      it "has a list of meals", :aggregate_failures do
        create_list(:meal, 3)

        expect(Meal.last.name).to eq("Banana Nut")
        expect(Meal.all.size).to eq(3)
      end

      it "we have no meals" do
        get :index

        expect(Meal.all.size).to eq(0)
      end
    end

    describe "#show" do
      it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
        create(:meal)
        get :show, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :show
      end

      context "we have a meal" do
        it "shows the right meal", :aggregate_failures do
          create(:meal)
          get :show, params: { id: 1 }

          expect(Meal.all.size).to eq(1)
          expect(Meal.last.id).to eq(1)
          expect(Meal.last.id).not_to eq(7)
          expect(Meal.last.name).to eq("Banana Nut")
        end
      end

      context "the meal does not exist" do
        it "does not load the meal" do
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
        create(:meal)
        get :edit, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :edit
      end

      it "redirects to the correct page" do
        create(:meal)
        put :update, params: { :meal => valid_update_params, :id => 1 }
        expect(response).to have_http_status(302)
        response.should redirect_to("/meals/1")
      end
    end

    describe "#create" do
      it "creates a new meal", :aggregate_failures do
        expect{
          post :create, params: { :meal => valid_params }
        }.to change{Meal.count}.by(1)
        expect(Meal.last.name).to eq("Banana Nut")
        expect(Meal.last.description).to eq("Bananas and nuts")
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :meal => valid_params }
        response.code.should == "302"
        response.should redirect_to("/meals/1")
      end

      it "doesn't create a new meal with invalid params", :aggregate_failures do
        expect{
          post :create, params: { :meal => invalid_params }
        }.to change{Meal.count}.by(0)
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :meal => invalid_params }
        response.code.should == "200"
        response.should render_template(:new)
      end
    end

    describe "#update" do
      before(:each) do
        create(:meal)
      end

      it "updates the correct meal", :aggregate_failures do
        put :update, params: { id: 1, :meal => valid_update_params }
        expect(Meal.last.id).to eq(1)
        expect(Meal.last.name).to eq("Updated Name")
        expect(Meal.last.description).to eq("Updated Description")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :meal => valid_update_params }
        response.code.should == "302"
        response.should redirect_to("/meals/1")
        end

      it "doesn't update meal with invalid params", :aggregate_failures do
        put :update, params: { id: 1, :meal => invalid_params }
        expect(Meal.last.id).to eq(1)
        expect(Meal.last.name).to eq("Banana Nut")
        expect(Meal.last.description).to eq("Bananas and nuts")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :meal => invalid_params }
        response.code.should == "200"
        response.should render_template(:edit)
      end
    end

    describe "#destroy" do
      before(:each) do
        create_list(:meal, 2)
      end

      context "we the correct meal" do
        it "destroys the correct meal", :aggregate_failures do
          expect{ post :destroy, params: { :id => 1 } }.to change{ Meal.all.size }.by(-1)
          expect(Meal.last.id).to eq(2)
        end

        it "redirects to the correct page", :aggregate_failures do
           post :destroy, params: { id: 1 }
           response.code.should == "302"
            response.should redirect_to("/meals")
        end
      end
      context "we don't have a meal", :aggregate_failures do
        it "destroys nothing" do
          expect{ post :destroy, params: { :id => 7 } }.to raise_exception(ActiveRecord::RecordNotFound)
          expect(Meal.all.size).to eq(2)
          expect(Meal.first.id).to eq(1)
          expect(Meal.last.id).to eq(2)
        end
      end
    end
  end
end
