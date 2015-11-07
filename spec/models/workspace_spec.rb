require 'rails_helper'

RSpec.describe Workspace ,type: :model do
  describe "Validations" do
    it { is_expected.to validate_presence_of :name }
  end

end
