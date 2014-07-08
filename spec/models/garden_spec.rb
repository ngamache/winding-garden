#spec/models/garden_spec.rb
require_relative './spec_helper'

describe Garden do
  before :all do
    @test_garden = create(:garden)
    @test_branch1 = create(:branch, garden: @test_garden)
    @test_branch2 = create(:branch, garden: @test_garden)
    @new_description = 'This is a new description'
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
  it 'deletes records' do
    test_name = @test_garden.name
    test_description = @test_garden.description
    @test_garden.destroy
    found_gardens = Garden.where(name: test_name)
    expect(found_gardens.count).to eq(0)
  end

end
