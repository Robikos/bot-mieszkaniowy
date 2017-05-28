require "HTTParty"
require "Nokogiri"

namespace :olx do
  desc "Scan OLX and check new flats"
  task scan: :environment do
    url = ENV["OLX_URL"] || Rails.application.secrets[:olx_url]
    page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(page)

    last_flats = parsed_page.css("#offers_table .offer")

    results = []

    last_flats.each do |flat|
      flat_title = flat.css("a").first.text
      flat_link = flat.css("a").first["href"]
      break if flat_title == last_flat_olx.title
      results << { title: flat_title, link: flat_link }
    end

    last_flat_olx.update_attributes(title: results.first[:title]) if results.any?

    puts results
  end
end

def last_flat_olx
  @last_flat_olx ||= LastFlat.olx
end
