require 'active_support/all'

def generate_release_text(prs, semver_tag)
  announcement = "About to release v#{semver_tag}"
  gh_text = [ ]
  slack_text = [announcement ]

  prs.each do |pr|
    pr = PrDetails.new(pr)
    next if pr.mergeback?

    gh_text << "* [#{pr.jira_id}](#{pr.jira_url}) #{pr.title} - #{pr.author} [#{pr.number}](#{pr.url})"
    slack_text << "#{pr.title} - #{pr.slack_author}"
  end

  [gh_text, slack_text]
end

class PrDetails
  attr_reader :number

  def slack_author
    AUTHORS[author]
  end

  def initialize(number)
    @number = number
  end

  def url
    @url ||= lines[9].split(" ").last
  end

  def title
    if jira_id.present?
      title_with_id.
        gsub(jira_id, '').
        gsub(/^[\]\:\-\ \)]+/, '')
    else
      title_with_id
    end
  end

  def title_with_id
    @title_with_id ||- lines.first.gsub(/^title:/, '').strip
  end

  def author
    @author ||= '@' + lines[2].gsub(/^author:/, '').strip
  end

  def jira_url
    @jira_url ||=  "https://silkfred.atlassian.net/browse/#{jira_id}"
  end

  def jira_id
    @jira_id ||= `echo #{title_with_id} | flow-jira-detect-ticket-id | head`.chomp
  end

  def mergeback?
    ((title =~ /merge/i) && (title =~ /master/i)) ||
      (title =~ /mergeback/i) ||
      ( (title =~ /master/i) && (title =~ /develop/i) )
  end

  private

  def self.authors
    CSV.read(File.expand_path('../authors', __FILE__), headers: true)
  end

  AUTHORS = authors.to_a[1..].each_with_object({}){|(k,v), h| h[k] = v }

  def lines
    @lines ||= result.split("\n")
  end

  def result
    @result ||= `gh pr view #{@number.gsub('#', '')}`
  end
end
