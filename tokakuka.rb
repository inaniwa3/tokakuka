#! ruby -Ku
# coding: utf-8

require "uri"
require "mechanize"

class Tokakuka
  def initialize
    @agent = Mechanize.new
    @agent.user_agent_alias = "Windows Mozilla"
  end

  def agent_get(place)
    begin
      @page = @agent.get(URI.escape("http://ja.wikipedia.org/wiki/#{place}"))
    rescue Mechanize::ResponseCodeError => ex
      puts "わからない"
      return false
    end
    return true
  end

  def try_1
    @page.search("table.infobox").search("tr").each do |m|
      if m.text.include?("正式名称")
        m.text =~ /([国都道府県市区町村])立/
        return $1 unless $1.nil?
      end
      if m.text.include?("事業主体")
        m.text =~ /([国都道府県市区町村])/
        return $1 unless $1.nil?
      end
      if m.text.include?("運営")
        return "都" if m.text =~ /東京都歴史文化財団/
        m.text =~ /([国都道府県市区町村])/
        return $1 unless $1.nil?
      end
    end
    return nil
  end

  def try_2
    m = @page.search("table.infobox").search("tr")
    if m.nil?
      m.first.text =~ /([国都道府県市区町村])立/
      return $1 unless $1.nil?
    end
    return nil
  end

  def execute(place)
    return nil unless agent_get(place)
    result = try_1
    result = try_2 if result.nil?
    unless result.nil?
      puts "#{result}がやってる"
    else
      puts "わからない"
    end
    return result
  end
end

if __FILE__ == $0
  t = Tokakuka.new
  t.execute(ARGV[0].encode("UTF-8"))
end
