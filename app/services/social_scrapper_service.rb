require 'capybara/poltergeist'

class SocialScrapperService
  attr_reader :fox_articles, :cnn_articles, :nbc_articles

  def initialize(cnn_articles, fox_articles, nbc_articles)
    @fox_articles = fox_articles
    @cnn_articles = cnn_articles
    @nbc_articles = nbc_articles
  end

  def perform
    browser = init_capybara
    social_bearing_scrapper(browser, @cnn_articles)
    social_bearing_scrapper(browser, @fox_articles)
    social_bearing_scrapper(browser, @nbc_articles)
    quit_capybara(browser)
  end

  private

  def init_capybara
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, js_errors: false, timeout: 2000, phantomjs_options: ['--load-images=false', '--ignore-ssl-errors=yes'])
    end
    Capybara.default_driver = :poltergeist
    Capybara.current_session
  end

  def social_bearing_scrapper(browser, medium_articles)
    medium_articles.each do |article|
      url_article = article['url']
      url = "https://socialbearing.com/search/general/http://www.foxnews.com/politics/2018/02/01/trump-to-declassify-surveillance-memo-sources-say.html"
      browser.visit url

      ajax_load_button(browser)

      social_kpi_scrapper(browser, article)
      hashtag_cloud_scrapper(browser, article)
      word_cloud_scrapper(browser, article)
    end
  end

  def ajax_load_button(browser)
    loop do
      if browser.has_no_css?('.inactive', visible: true, wait: 15)
        browser.find('a.load_more').click
      else
        browser.find('h2.tweet-count').text
        break
      end
    end

    if browser.find('h2.tweet-count').text.split('').last == '0'
      loop do
        if browser.has_no_css?('.inactive', visible: true, wait: 30)
          browser.find('a.load_more').click
        else
          browser.find('h2.tweet-count').text
          break
        end
      end
    end
  end

  def social_kpi_scrapper(browser, article)
    article['tweet_count'] = browser.find('h2.tweet-count').text.to_i
    article['total_reach'] = browser.find('span.total-reach').text.to_i
    article['total_impression'] = browser.find('span.total-impressions').text.to_i
    article['total_retweet'] = browser.find('h2.total-retweet').text.to_i

    if browser.find('h2.tweet-timeframe').text == '1 day'
      article['tweet_timeframe'] = 24
    else
      raw_tweet_timeframe = browser.find('h2.tweet-timeframe').text.split("")
      article['tweet_timeframe'] = raw_tweet_timeframe[0...-1].join.to_i
    end
  end

  def hashtag_cloud_scrapper(browser, article)
    if browser.find_by_id('hash_cloud')
      hashtag_cloud = []
      browser.find_by_id('hash_cloud').all('span').each do |hash_tag_span|
        pair = []
        pair << hash_tag_span.text
        pair << hash_tag_span['class'].slice(1).to_i
        hashtag_cloud << pair
      end
      article['hashtag_cloud'] = hashtag_cloud
      end
  end

  def word_cloud_scrapper(browser, article)
    if browser.find_by_id('word_cloud')
      word_cloud = []
      browser.find_by_id('word_cloud').all('span').each do |word_span|
        pair = []
        pair << word_span.text
        pair << word_span['class'].slice(1).to_i
      end
      article['word_cloud'] = word_cloud
      end
  end

  def quit_capybara(browser)
    browser.reset_session!
    browser.driver.quit
    browser = nil
  end
end
