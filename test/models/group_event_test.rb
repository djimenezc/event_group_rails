require 'test_helper'

class GroupEventTest < ActiveSupport::TestCase

  setup do
    @group_event_published = group_events(:two)
    @group_event = group_events(:one)
    @group_event_not_valid = group_events(:six)
    @group_event_no_end_date = group_events(:three)
  end

  test 'the status is published' do

    assert @group_event_published.status == 'Published'
  end

  test 'the status is not published' do

    assert @group_event.status == 'Draft'
  end

  test 'end date is calculate using the duration and start date fields' do

    assert @group_event_no_end_date.end_date != nil
    assert @group_event_no_end_date.end_date == Date.strptime('{ 2015, 9, 17 }', '{ %Y, %m, %d }')
  end
end
