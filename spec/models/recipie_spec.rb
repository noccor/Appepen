require "rails_helper"

RSpec.describe Recipie, :type => :model do
  describe "assosiations" do
    it { is_expected.to belong_to :meal }
    it { is_expected.to belong_to :ingredient }
  end
end
