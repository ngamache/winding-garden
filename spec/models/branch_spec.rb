#spec/models/branch_spec.rb
require_relative './spec_helper'

describe Branch do
  before :all do
    @test_branch = create(:branch)
    @test_garden = @test_branch.garden
  end
  
  after :all do
    garden_user = @test_garden.user
    branch_user = @test_branch.user
    @test_branch.destroy
    @test_garden.destroy
    garden_user.destroy
    branch_user.destroy
  end

  it 'has a valid factory' do
    expect(@test_branch).to be_valid
  end
  it 'retrieves name and description' do
    found_branch = Garden.where(name: @test_garden.name).first.branches.where(name: @test_branch.name).first
    expect(found_branch.description).to eq(@test_branch.description)
  end
  it 'changes the description' do
    new_description = 'This is a new description'
    @test_branch.description = new_description
    @test_branch.save
    found_branch = Garden.where(name: @test_garden.name).first.branches.where(name: @test_branch.name).first
    expect(found_branch.description).to eq(new_description)
  end
  
  it 'cannot unset creator' do
    old_user = @test_branch.user
    @test_branch.user = NIL
    expect(@test_branch).to be_invalid
    @test_branch.user = old_user
  end

  it 'cannot duplicate a name in the same garden' do
    dup_name = create(:branch, garden: @test_garden)
    dup_name.name = @test_branch.name
    expect(dup_name.valid?).to eq(false)
    dup_name.user.destroy
    dup_name.destroy
  end

  it 'can duplicate a name in a different garden' do
    new_garden = create(:garden)
    dup_name = create(:branch, garden: new_garden)
    dup_name.name = @test_branch.name
    expect(dup_name.valid?).to eq(true)
    new_garden.user.destroy
    new_garden.destroy
    dup_name.user.destroy
    dup_name.destroy
  end
  
  it 'sets the creator' do
    new_user = create(:user)
    new_username = new_user.username
    old_user = @test_branch.user
    @test_branch.user = new_user
    found_user = Garden.where(name: @test_garden.name).first.branches.where(name: @test_branch.name).first.user
    expect(found_user.username).to eq(new_username)
    old_user.destroy
  end
  
  it 'deletes records' do
    test_name = @test_branch.name
    @test_branch.destroy
    found_branches = @test_garden.branches.where(name: test_name)
    expect(found_branches.count).to eq(0)
  end

end
