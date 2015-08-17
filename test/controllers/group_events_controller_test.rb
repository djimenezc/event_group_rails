require 'test_helper'

class GroupEventsControllerTest < ActionController::TestCase
  setup do
    @group_event = group_events(:one)
    @group_event_not_filled = group_events(:six)
  end

  test 'should get index' do
    get :index, :format => :json

    records = JSON.parse(response.body)

    assert_response :success
    assert_not_nil assigns(:group_events)
    assert records.length == 3
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create group_event' do
    assert_difference('GroupEvent.count', 1) do
      post :create, group_event: {:name => 'hello'}, :format => :json
    end

    assert response.status == 201
  end

  test 'should create group_event html' do
    assert_difference('GroupEvent.count', 1) do
      post :create, group_event: {:name => 'hello'}
    end

    assert_redirected_to group_event_path(assigns(:group_event))
  end

  test 'should show group_event' do
    get :show, id: @group_event, :format => :json
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @group_event
    assert_response :success
  end

  test 'should update group_event' do
    patch :update, id: @group_event, group_event: {:name => 'nameChanged'}, :format => :json

    get :show, id: @group_event, :format => :json

    records = JSON.parse(response.body)

    assert records.size == 10
    assert records['name'] == 'nameChanged'
  end

  test 'should update group_event html' do
    patch :update, id: @group_event, group_event: {:name => 'nameChanged'}
    assert_redirected_to group_event_path(assigns(:group_event))
  end

  test 'should delete group_event, mark it as deleted html' do
    # the destroy action should mark the record as deleted

    assert !@group_event.deleted

    assert_difference('GroupEvent.count', 0) do
      delete :delete, id: @group_event
    end

    group_event_updated = GroupEvent.where :name => 'MyString1'
    assert group_event_updated[0].deleted, 'Record not deleted properly'

    assert_redirected_to group_events_path
  end

  test 'should delete group_event, mark it as deleted ' do
    # the destroy action should mark the record as deleted

    assert !@group_event.deleted

    assert_difference('GroupEvent.count', 0) do
      delete :delete, id: @group_event, :format => :json
    end

    group_event_updated = GroupEvent.where :name => 'MyString1'
    assert group_event_updated[0].deleted, 'Record not deleted properly'

  end

  test 'should publish group_event' do

    assert !@group_event.published

    get :publish, id: @group_event, :format => :json

    assert response.status == 204

    group_event_updated = GroupEvent.where :name => 'MyString1'
    assert group_event_updated[0].published, 'Record not published properly'
  end

  test 'should publish group_event html' do

    assert !@group_event.published

    get :publish, id: @group_event

    group_event_updated = GroupEvent.where :name => 'MyString1'
    assert group_event_updated[0].published, 'Record not published properly'

    assert_redirected_to group_events_path
  end

  test 'should not publish group_event, all fields are required' do

    assert !@group_event_not_filled.published

    get :publish, id: @group_event_not_filled, :format => :json

    assert response.status == 422

    records = JSON.parse(response.body)
    assert records.include? 'errors'
  end

end
