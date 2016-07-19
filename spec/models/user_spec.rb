require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)  { create(:user) }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without email" do
    expect(build(:user, email: '')).to_not be_valid
  end

  it "is invalid without password" do
    expect(build(:user, password: '')).to_not be_valid
  end

  it "checks password min length" do
    expect(build(:user, password: '1')).to_not be_valid
  end

  it "checks that email is unique" do
    user
    expect(build(:user, email: user.email)).to_not be_valid
  end

end
