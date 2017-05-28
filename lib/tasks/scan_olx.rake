require "httparty"
require "nokogiri"

namespace :olx do
  desc "Scan OLX and check new flats"
  task scan: :environment do
    url = ENV["OLX_URL"] || Rails.application.secrets[:olx_url]
    page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(page)

    last_flats = parsed_page.css("#offers_table .offer")

    results = []

    last_flats.each do |flat|
      flat_title = flat.css("a strong").first.text
      flat_link = flat.css("a").first["href"]
      break if flat_title == last_flat_olx.title
      results << { title: flat_title, link: flat_link }
    end

    last_flat_olx.update_attributes(title: results.first[:title]) if results.any?

    results.each do |result|
      send_to_facebook(result)
    end
  end
end

def last_flat_olx
  @last_flat_olx ||= LastFlat.olx
end

def send_to_facebook(result)
  User.all.each do |user|
    Messenger::Client.send(
      Messenger::Request.new(
        Messenger::Elements::Text.new(text: make_result_text(result, user)),
        user.messenger_id
      )
    )
  end
end

def make_result_text(result, user)
  "Siemka #{user.name}! Nowa oferta:" + "#{result[:title]} : #{result[:link]}"
end
