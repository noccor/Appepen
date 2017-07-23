require "rails_helper"

RSpec.describe Meal, :type => :model do
  describe "assosiations" do
    it { is_expected.to belong_to :menu }
  end
end
