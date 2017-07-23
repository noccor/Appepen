require "rails_helper"

RSpec.describe RecipiesController, :cat => :controller do
  before do
  create(:menu)
  create(:ingredient)
  end

  let(:valid_params) do
    {
      menu_id: 1,
      ingredient_id: 1,
      modify: true,
      quantity: 100,
      measure: "grams"
    }
  end

  let(:valid_update_params) do
    {
      menu_id: 1,
      ingredient_id: 1,
      modify: true,
      quantity: 100,
      measure: "ml"
    }
  end

  let(:invalid_params) do
    {
      menu_id: nil,
      ingredient_id: nil
    }
  end

  describe "#index" do
    it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      response.should render_template :index
    end

    context "We have recipies" do
      it "has a list of recipies", :aggregate_failures do
        create_list(:recipie, 3)

        expect(Recipie.last.measure).to eq("grams")
        expect(Recipie.all.size).to eq(3)
      end

      it "we have no recipies" do
        get :index

        expect(Recipie.all.size).to eq(0)
      end
    end

    describe "#show" do
      it "responds sucessfull with a HTTP 200 status", :aggregate_failures do
        create(:recipie)
        get :show, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :show
      end

      context "we have a recipie" do
        it "shows the right recipie", :aggregate_failures do
          create(:recipie)
          get :show, params: { id: 1 }

          expect(Recipie.all.size).to eq(1)
          expect(Recipie.last.id).to eq(1)
          expect(Recipie.last.id).not_to eq(7)
          expect(Recipie.last.measure).to eq("grams")
        end
      end

      context "the recipie does not exist" do
        it "does not load the recipie" do
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
        create(:recipie)
        get :edit, params: { id: 1 }

        expect(response).to be_success
        expect(response).to have_http_status(200)
        response.should render_template :edit
      end

      it "redirects to the correct page" do
        create(:recipie)
        put :update, params: { :recipie => valid_update_params, :id => 1 }
        expect(response).to have_http_status(302)
        response.should redirect_to("/recipies/1")
      end
    end

    describe "#create" do
      it "creates a new recipie", :aggregate_failures do
        expect{
          post :create, params: { :recipie => valid_params }
        }.to change{Recipie.count}.by(1)
        expect(Recipie.last.measure).to eq("grams")
        expect(Recipie.last.quantity).to eq(100)
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :recipie => valid_params }
        response.code.should == "302"
        response.should redirect_to("/recipies/1")
      end

      it "doesn't create a new recipie with invalid params", :aggregate_failures do
        expect{
          post :create, params: { :recipie => invalid_params }
        }.to change{Recipie.count}.by(0)
      end

      it "redirects to the correct page", :aggregate_failures do
        post :create, params: { :recipie => invalid_params }
        response.code.should == "200"
        response.should render_template(:new)
      end
    end

    describe "#update" do
      before(:each) do
        create(:recipie)
      end

      it "updates the correct recipie", :aggregate_failures do
        put :update, params: { id: 1, :recipie => valid_update_params }
        expect(Recipie.last.id).to eq(1)
        expect(Recipie.last.measure).to eq("ml")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :recipie => valid_update_params }
        response.code.should == "302"
        response.should redirect_to("/recipies/1")
        end

      it "doesn't update recipie with invalid params", :aggregate_failures do
        put :update, params: { id: 1, :recipie => invalid_params }
        expect(Recipie.last.id).to eq(1)
        expect(Recipie.last.measure).to eq("grams")
      end

      it "redirects to the correct page", :aggregate_failures do
        put :update, params: { id: 1, :recipie => invalid_params }
        response.code.should == "200"
        response.should render_template(:edit)
      end
    end

    describe "#destroy" do
      before(:each) do
        create_list(:recipie, 2)
      end

      context "we the correct recipie" do
        it "destroys the correct recipie", :aggregate_failures do
          expect{ post :destroy, params: { :id => 1 } }.to change{ Recipie.all.size }.by(-1)
          expect(Recipie.last.id).to eq(2)
        end

        it "redirects to the correct page", :aggregate_failures do
           post :destroy, params: { id: 1 }
           response.code.should == "302"
            response.should redirect_to("/recipies")
        end
      end
      context "we don't have a recipie", :aggregate_failures do
        it "destroys nothing" do
          expect{ post :destroy, params: { :id => 7 } }.to raise_exception(ActiveRecord::RecordNotFound)
          expect(Recipie.all.size).to eq(2)
          expect(Recipie.first.id).to eq(1)
          expect(Recipie.last.id).to eq(2)
        end
      end
    end
  end
end
