require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  test "bulk import: valid csv" do
    course  = Course.new name: "course 1"
    assert course.save
    course.bulk_enroll File.open('test/fixtures/files/valid.csv')
  end

  test "bulk import: invalid csv" do
    course  = Course.new name: "course 1"
    assert course.save
    assert_raise Exception do
      course.bulk_enroll File.open('test/fixtures/files/some.csv')
    end
  end

end
