#spec/models/leaf_spec.rb
require_relative './spec_helper'

describe Leaf do
  before :all do
    @test_leaf = create(:leaf)
    @test_branch1 = create(:leaf_branch, branching: @test_leaf)
    @new_body = 'This is a new body'
  end
  
  after :all do
    leaf_user = @test_leaf.user
    branch_user = @test_branch1.user
    @test_leaf.destroy
    leaf_user.destroy
    branch_user.destroy
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
    @test_leaf.branch = @test_branch1
    @test_leaf.save
    found_leaf = Leaf.where(title: @test_leaf.title).first
    expect(found_leaf.branch.description).to eq(@test_branch1.description)
  end
  it 'modifies a branch' do
    @test_leaf.branch.description = @new_body
    @test_leaf.branch.save
    found_leaf = Leaf.where(title: @test_leaf.title).first
    expect(found_leaf.branch.description).to eq(@new_body)
  end
  it 'removes a branch' do
    @test_leaf.branch.delete
    expect(@test_leaf.branch).to be_nil
  end
  
  it 'cannot unset creator' do
    old_user = @test_leaf.user
    @test_leaf.user = NIL
    expect(@test_leaf).to be_invalid
    @test_leaf.user = old_user
  end
  
  it 'sets the creator' do
    new_user = create(:user)
    new_username = new_user.username
    old_user = @test_leaf.user
    @test_leaf.user = new_user
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
