class ScraperTest
  
  require 'open-uri'
  require 'nokogiri'
  
  def self.feed
    doc = Nokogiri::HTML(open('http://www.robertsosinski.com/'))
 
    posts = doc.search('div.post')
 
    entries = []
 
    posts.each do |post|
      id         = post.attributes['id'].delete('post-').to_i
      title      = post.search('h2').first.content
      permalink  = post.search('a[rel=bookmark]').first.attributes['href']
      categories = post.search('a[rel~=category]').collect { |category| category.content }
      date       = Date.parse(post.search('span.date').first.content)
      body       = post.search('p').first.content
 
      entries << {:id => id, :title => title, :permalink => permalink, 
                  :categories => categories, :date => date, :body => body}
    end
 
    return entries
  end
  
  
end