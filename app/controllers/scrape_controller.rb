class ScrapeController < ApplicationController
  def new
  end

  def create
    @products = []
    require 'httparty'
    urls = params[:urls].split(' ')

    urls.each do |url|
      response = HTTParty.get(url)
      parser = Nori.new
      parsed_hash = parser.parse(response.body)
      @keywords = params[:keywords]
      keyword_regexp = /#{Regexp.quote(@keywords)}/i

      @products << parsed_hash['urlset']['url'].select do |p|
        p["image:image"]["image:title"] =~ keyword_regexp if p["image:image"]
      end
    end

    @products.flatten!
  end
end
