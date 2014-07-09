#spec/models/garden_spec.rb
require_relative './spec_helper'

describe Garden do
  before :all do
    @test_garden = create(:garden)
    @test_branch1 = create(:garden_branch, branching: @test_garden)
    @test_branch2 = create(:garden_branch, branching: @test_garden)
    @new_description = 'This is a new description'
  end
  
  after :all do
    garden_user = @test_garden.user
    branch1_user = @test_branch1.user
    branch2_user = @test_branch2.user
    @test_garden.destroy
    garden_user.destroy
    branch1_user.destroy
    branch2_user.destroy
  end
  

  it 'has a valid factory' do
    expect(@test_garden).to be_valid
  end
  it 'retrieves name and description' do
    found_garden = Garden.where(name: @test_garden.name).first
    expect(found_garden.description).to eq(@test_garden.description)
  end
  it 'changes the description' do
    @test_garden.description = @new_description
    @test_garden.save
    found_garden = Garden.where(name: @test_garden.name).first
    expect(found_garden.description).to eq(@new_description)
  end
  it 'adds a branch' do
    @test_garden.branches = [@test_branch1]
    @test_garden.save
    found_garden = Garden.where(name: @test_garden.name).first
    expect(found_garden.branches.target[0].description).to eq(@test_branch1.description)
  end
  it 'modifies a branch' do
    @test_garden.branches.target[0].description = @new_description
    @test_garden.branches.target[0].save
    found_garden = Garden.where(name: @test_garden.name).first
    expect(found_garden.branches.target[0].description).to eq(@new_description)
  end
  it 'adds another branch' do
    @test_garden.branches.push(@test_branch2)
    @test_garden.save
    found_garden = Garden.where(name: @test_garden.name).first
    expect(@test_garden.branches.target.count).to eq(2)
    expect(found_garden.branches.target[1].description).to eq(@test_branch2.description)
  end
  it 'removes a branch' do
    @test_garden.branches.target.delete_at(1)
    expect(@test_garden.branches.target.count).to eq(1)
  end
  it 'removes all branches' do
    @test_garden.branches.destroy_all
    expect(@test_garden.branches.target.count).to eq(0)
  end
    
  it 'cannot unset creator' do
    old_user = @test_garden.user
    @test_garden.user = NIL
    expect(@test_garden).to be_invalid
    @test_garden.user = old_user
  end
  
  it 'sets the creator' do
    new_user = create(:user)
    new_username = new_user.username
    old_user = @test_garden.user
    @test_garden.user = new_user
    found_user = Garden.where(name: @test_garden.name).first.user
    expect(found_user.username).to eq(new_username)
    old_user.destroy
  end
  
  it 'deletes records' do
    test_name = @test_garden.name
    test_description = @test_garden.description
    @test_garden.destroy
    found_gardens = Garden.where(name: test_name)
    expect(found_gardens.count).to eq(0)
  end

end
