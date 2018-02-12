require 'json'
require 'net/http'
require 'uri'
require "addressable/uri"
require 'cgi'

class WatsonApiService

  attr_reader :cnn_articles, :fox_articles, :nbc_articles

  def initialize(cnn_articles, fox_articles, nbc_articles)
    @cnn_articles = cnn_articles
    @fox_articles = fox_articles
    @nbc_articles = nbc_articles
  end

  def perform
    sentiment_analysis(@cnn_articles)
    sentiment_analysis(@fox_articles)
    sentiment_analysis(@nbc_articles)
  end

  def sentiment_analysis(medium_articles)
    medium_articles.each do |article|
      data_hash = call_api(article)
      article['sentiments_data'] = get_text_score(data_hash)
    end
  end


  def query_maker(article)
    my_query = {
      "emotion.document" => "true",
      "sentiment.document" => "true",
      "entities.type" => "true",
      "entities.emotion" => "true",
      "entities.sentiment" => "true",
      "features" => "keywords,entities",
      "keywords.emotion" => "true",
      "keywords.sentiment" => "true",
      "url" => article['url'],
      "version" => "2017-02-27",
    }
    uri = Addressable::URI.new
    uri.query_values = my_query
    uri.query
  end

  def call_api(article)
    uri = URI.parse("https://gateway.watsonplatform.net/natural-language-understanding/api/v1/analyze?version=2017-02-27&#{query_maker(article)}")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth("1439bd67-49cf-45a4-a47d-983c365fb7ad", "0lzxAyxQ2dxT")
    req_options = { use_ssl: uri.scheme == "https", }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) { |http| http.request(request) }
    JSON.parse(response.body)
  end

  def get_text_score(data_hash)
    array_entities = [] # array provisoire pour stocker les entities repérées
    data_hash["entities"].each { |entitie| array_entities << entitie["text"] } # on stocke les entities repérées dans le array
      array_entities
    text_score = array_entities.each_index.select { |i| array_entities[i].include? 'Trump' } # on cherche à quels index du array les entities répondent à la condition include? 'Trump'
    results = [] # array provisoire pour stocker le score de sentiment et le score des émotions pour chaque entitie qui répond à la condition entitie is a Person
    text_score.each do |index|
      text_score
      data_hash["entities"][index]["type"]
      results << data_hash["entities"][index]["sentiment"].merge(data_hash["entities"][index]["emotion"]) if data_hash["entities"][index]["type"] == "Person"
    end # on stock dans le array sous forme de deux hashs le sentiment et les émotions de ou des entities qui répondent à la condition "Person" et on fusionne les deux hashs.
     results
     final_result = results.each { |result| result.delete("label") } # on supprime le label (postif ou négatif) ou cas ou en devraient aggréger plusieurs valeurs si il y a plusieurs occurences de l'entitie Trump as a Person.
    average_values = final_result.map(&:values).transpose.map { |arr| (arr.map(&:to_f).inject(:+) / arr.size).round(2) } # on calcul la moyenne des values pour les score et les émotions avec un arrondi à 2 décimales si plusieurs entities matchent la condition Trump as a Person.
    with_keys = Hash[final_result.first.keys.zip(average_values)] # on renvoit la moyenne du score et des émotions sous forme de hash pour toutes les entities qui matchent.
  end
end
