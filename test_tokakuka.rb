#! ruby -Ku
# coding: utf-8

require "minitest/unit"
require "minitest/autorun"
require "./tokakuka.rb"

class TestTokakuka < MiniTest::Unit::TestCase
  def setup
    @tokakuka = Tokakuka.new
  end

  def test_on_air
    assert_equal "都", @tokakuka.execute("東京芸術劇場")
    assert_equal "区", @tokakuka.execute("浅草公会堂")
    assert_equal "都", @tokakuka.execute("葛西臨海水族園")
    # assert_equal "区", @tokakuka.execute("新宿コズミックセンター")
    assert_equal "都", @tokakuka.execute("上野動物園")
    # assert_equal "市", @tokakuka.execute("あきる野ルピア")
    assert_equal "都", @tokakuka.execute("江戸東京たてもの園")
    # assert_equal "区", @tokakuka.execute("わんぱく天国")
    assert_equal "市", @tokakuka.execute("パルテノン多摩")
    assert_equal "国", @tokakuka.execute("新国立劇場")
  end

  def test_others
    assert_equal "区", @tokakuka.execute("しながわ水族館")
    assert_equal "国", @tokakuka.execute("国立国会図書館")
    assert_equal "国", @tokakuka.execute("お札と切手の博物館")
    assert_equal "市", @tokakuka.execute("三鷹の森ジブリ美術館")
    assert_equal "市", @tokakuka.execute("せんだいメディアテーク")
  end

  def test_dont_know
    assert_equal nil, @tokakuka.execute("落合博満野球記念館")
  end
end
