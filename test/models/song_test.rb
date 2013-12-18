require_relative '../test_helper'

class SongTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Song.all.each do |song|
      assert song.valid?, song.errors.inspect
    end
  end

  def test_validation
    song = Song.new
    assert song.invalid?
    assert_errors_on song, :name, :artist, :year
  end

  def test_creation
    assert_difference 'Song.count' do
      Song.create(
        :name => 'test name',
        :artist => 'test artist',
        :year => 'test year',
      )
    end
  end

end