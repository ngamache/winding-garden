#spec/models/path_spec.rb
require_relative './spec_helper'

describe Path do
  before :all do
    @test_path = create(:path)
    @new_user = create(:user)
    @old_user = @test_path.user
    @new_garden = create(:garden)
    @old_garden = @test_path.garden
    @old_user = @test_path.user
    @test_leaf = create(:leaf)
  end
  
  after :all do
    @test_path.destroy
    @new_user.destroy
    @old_user.destroy
    @new_garden.user.destroy
    @old_garden.user.destroy
    @new_garden.destroy
    @old_garden.destroy
    @test_leaf.user.destroy
    @test_leaf.garden.user.destroy
    @test_leaf.garden.destroy
    @test_leaf.stones.first.destroy
    @test_leaf.destroy
  end

  it 'has a valid factory' do
    expect(@test_path).to be_valid
  end
  
  it 'cannot unset creator' do
    @test_path.user = NIL
    expect(@test_path).to be_invalid
    @test_path.user = @old_user
  end
  
  it 'sets the creator' do
    @test_path.user = @new_user
    found_user = Path.where(garden_id: @test_path.garden_id).first.user
    expect(found_user.username).to eq(@new_user.username)
  end
  
  it 'cannot unset garden' do
    @test_path.garden = NIL
    expect(@test_path).to be_invalid
    @test_path.garden = @old_garden
  end
  
  it 'sets the garden' do
    @test_path.garden = @new_garden
    @test_path.save
    found_garden = Path.find(@test_path.id).garden
    expect(found_garden.name).to eq(@new_garden.name)
  end
  
  it 'adds a stone' do
    @test_path.step_on_stone(@test_leaf)
    found_path = Path.find(@test_path.id)
    expect(found_path.stones.count).to eq(1)
    expect(found_path.stones.first.leaf).to eq(@test_leaf)
  end
  
  it 'removes a stone' do
    @test_path.untread_stone(@test_leaf)
    found_path = Path.find(@test_path.id)
    expect(found_path.stones.count).to eq(0)
  end
  
  it 'sets the time on the stone correctly' do
    @test_path.step_on_stone(@test_leaf)
    found_path = Path.find(@test_path.id)
    expect(found_path.stones.first.stepped.to_time.to_i).to be_within(3).of(Time.now.to_i)
  end
  
  it 'sets the time via upsert correctly' do
    first_time = @test_path.stones.first.stepped.to_time.to_i
    sleep 2
    @test_path.step_on_stone(@test_leaf)
    found_path = Path.find(@test_path.id)
    expect(found_path.stones.count).to eq(1)
    expect(found_path.stones.first.stepped.to_time.to_i).to be > (first_time)    
  end
  
end