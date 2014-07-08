#spec/models/branch_spec.rb
require_relative './spec_helper'

describe Branch do
  before :all do
    @test_branch = create(:branch)
    @test_garden = @test_branch.garden
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
  it 'deletes records' do
    test_name = @test_branch.name
    test_description = @test_branch.description
    @test_branch.destroy
    found_branches = Garden.where(name: test_name)
    expect(found_branches.count).to eq(0)
  end

end