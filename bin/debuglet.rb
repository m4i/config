#!/usr/bin/env ruby
#
# http://let.hatelabo.jp/help

api_key = ENV['DEBUGLET_API_KEY']

require 'net/http'
require 'uri'

api_uri = URI('http://let.hatelabo.jp/api/code.save')
options = { 'api_key' => api_key }

if ARGV.length > 0
    req = Net::HTTP::Post.new('/api/code.save')
    req.set_form_data({ 'source' => open(ARGV.shift).read }.update(options), ';')
    Net::HTTP.start(api_uri.host, api_uri.port) do |http|
        http.request(req)
    end
else
    req = Net::HTTP::Post.new('/api/code')
    req.set_form_data(options, ';')
    Net::HTTP.start(api_uri.host, api_uri.port) do |http|
        puts http.request(req).body.gsub(/\r\n/, "\n")
        puts
    end
end
