class Url < ActiveRecord::Base
  # Remember to create a migration!
  validate :sexy_url
  before_create :make_short_url
  belongs_to :user

  def sexy_url
    uri = URI.parse(self.long_url)
    if uri.class != URI::HTTP
      errors.add(:url, 'Only HTTP protocol addresses can be used')
      return false
    end
    rescue URI::InvalidURIError 
      errors.add(:url, 'The format of the url is not valid.')
      return false
  end

  def make_short_url
    url = (0...5).map{(97+rand(25)).chr}.join
    until unique?(url) 
      url = (0...5).map{(97+rand(25)).chr}.join
    end
    self.short_url = url
  end

  def unique?(url)
    Url.find_by_short_url(url) ? false : true
  end
end
