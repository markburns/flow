#!/usr/bin/env ruby
# frozen_string_literal: true
require 'faraday'
require 'base64'

module Jira
  CONTROL_CHARACTERS = ("\x00".."\x1f").to_a.join('|')
  REGEX = /#{CONTROL_CHARACTERS}/.freeze

  def self.request(verb, url_path, body)
    url = "https://#{ENV['JIRA_SUBDOMAIN']}.atlassian.net/#{url_path}"

    result = Faraday.send(verb, url, body, {authorization: "Basic #{encoded_auth}"}).body

    result.force_encoding('utf-8')
    result.gsub!(REGEX, ' ')

    result
  end

  def self.encoded_auth
    Base64.encode64("#{ENV['JIRA_USERNAME']}:#{ENV['JIRA_TOKEN']}").split("\n").join("").chomp
  end
end

# JIRA responses include new lines and other control characters
# and jq doesn't like that
