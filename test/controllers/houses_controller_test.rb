require "test_helper"

class HousesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @house = houses(:one)
  end

  test "should get index" do
    get houses_url, as: :json
    assert_response :success
  end

  test "should create house" do
    assert_difference("House.count") do
      post houses_url, params: { house: { amenities: @house.amenities, available_from: @house.available_from, available_to: @house.available_to, description: @house.description, max_guests: @house.max_guests, name: @house.name } }, as: :json
    end

    assert_response :created
  end

  test "should show house" do
    get house_url(@house), as: :json
    assert_response :success
  end

  test "should update house" do
    patch house_url(@house), params: { house: { amenities: @house.amenities, available_from: @house.available_from, available_to: @house.available_to, description: @house.description, max_guests: @house.max_guests, name: @house.name } }, as: :json
    assert_response :success
  end

  test "should destroy house" do
    assert_difference("House.count", -1) do
      delete house_url(@house), as: :json
    end

    assert_response :no_content
  end
end
