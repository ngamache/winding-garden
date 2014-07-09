#spec/models/user_spec.rb
require_relative './spec_helper'

describe User do
  before :all do
    @test_user = create(:user)
  end
  
  after :all do
    @test_user.destroy
  end

  it 'has a valid factory' do
    expect(@test_user).to be_valid
  end
  it 'retrieves username and email' do
    found_user = User.where(username: @test_user.username).first
    expect(found_user.email).to eq(@test_user.email)
  end
  it 'changes the email' do
    new_email = 'new@email.com'
    @test_user.email = new_email
    @test_user.save
    found_user = User.where(username: @test_user.username).first
    expect(found_user.email).to eq(new_email)
  end
  it 'will not change to an invalid email' do
    new_email = 'invalid'
    old_email = @test_user.email
    @test_user.email = new_email
    expect(@test_user.valid?).to eq(false)
    @test_user.save
    found_user = User.where(username: @test_user.username).first
    expect(found_user.email).to eq(old_email)
  end
  it 'deletes records' do
    test_username = @test_user.username
    @test_user.destroy
    found_users = Garden.where(username: test_username)
    expect(found_users.count).to eq(0)
  end

end
