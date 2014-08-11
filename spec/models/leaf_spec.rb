#spec/models/leaf_spec.rb
require_relative './spec_helper'

describe Leaf do
  before :all do
    @test_leaf = create(:leaf)
    @test_branch1 = create(:branch)
    @new_body = 'This is a new body'
    @new_user = create(:user)
    @new_garden = create(:garden)
    @old_garden = @test_leaf.garden
  end
  
  after :all do
    leaf_user = @test_leaf.user
    branch_user = @test_branch1.user
    branch_garden = @test_branch1.garden
    garden_user = @test_leaf.garden.user
    garden2_user = @new_garden.user
    @test_leaf.destroy
    leaf_user.destroy
    @test_branch1.destroy
    branch_user.destroy
    @new_user.destroy
    garden_user.destroy
    garden2_user.destroy
    @new_garden.destroy
    branch_garden.user.destroy
    branch_garden.destroy
    @old_garden.user.destroy
    @old_garden.destroy
  end

  it 'has a valid factory' do
    expect(@test_leaf).to be_valid
  end
  it 'retrieves name and description' do
    found_leaf = Leaf.where(title: @test_leaf.title).first
    expect(found_leaf.body).to eq(@test_leaf.body)
  end
  it 'changes the description' do
    @test_leaf.body = @new_body
    @test_leaf.save
    found_leaf = Leaf.where(title: @test_leaf.title).first
    expect(found_leaf.body).to eq(@new_body)
  end
  it 'adds a branch' do
    @test_leaf.branches << @test_branch1
    @test_leaf.save
    found_leaf = Leaf.where(title: @test_leaf.title).first
    expect(found_leaf.branches.first.description).to eq(@test_branch1.description)
  end
  it 'modifies a branch' do
    this_branch = @test_leaf.branches.where(name: @test_branch1.name).first
    this_branch.description = @new_body
    this_branch.save
    found_leaf = Leaf.where(title: @test_leaf.title).first
    expect(found_leaf.branches.where(name: @test_branch1.name).first.description).to eq(@new_body)
  end
  it 'removes a branch' do
    @test_leaf.branches.first.destroy
    expect(@test_leaf.branches.count).to eq(0)
  end
  it 'cannot unset garden' do
    old_garden = @test_leaf.garden
    @test_leaf.garden = NIL
    expect(@test_leaf).to be_invalid
    @test_leaf.garden = old_garden
  end  
  it 'sets the garden' do
    new_name = @new_garden.name
    @test_leaf.garden = @new_garden
    @test_leaf.save
    found_garden = Leaf.where(title: @test_leaf.title).first.garden
    expect(found_garden.name).to eq(new_name)
  end
  it 'cannot unset creator' do
    old_user = @test_leaf.user
    @test_leaf.user = NIL
    expect(@test_leaf).to be_invalid
    @test_leaf.user = old_user
  end
  
  it 'sets the creator' do
    new_username = @new_user.username
    old_user = @test_leaf.user
    @test_leaf.user = @new_user
    found_user = Leaf.where(title: @test_leaf.title).first.user
    expect(found_user.username).to eq(new_username)
    old_user.destroy
  end
  
  it 'deletes records' do
    test_title = @test_leaf.title
    body = @test_leaf.body
    @test_leaf.destroy
    found_leaf = Leaf.where(name: test_title)
    expect(found_leaf.count).to eq(0)
  end

end
