# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Article : titre, auteur, source, url, description, date de publication, url to image(?), les attributs sociaux, sentiment_article_score, article_emotions,  )
#

p "Destroying Articles..."
Article.destroy_all

p "Destroying Daily Analyses..."
DailyAnalysis.destroy_all

p "Destroying Medias"
Medium.destroy_all

p "Creating Media..."

media1_fox = Medium.create!(
  name:"Fox News",
  logo:"http://p14.zdassets.com/hc/settings_assets/63348/200430188/Nsmx0VrtWicyK9MvKEUphQ-1024.png",
  url:"http://www.foxnews.com/"
)

p "Done!"
p "Creating Daily Analysis!"
daily_analysis = DailyAnalysis.create!(
  fox_global_sentiment: [ -0.74758, "negative"]
  )
p "Done!"
p "Creating articles..."

fox_article1 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media1_fox,
  title:"Trump, in first State of the Union, talks 'safe, strong and proud America",
  author: "Fox News",
  url:"http://www.foxnews.com/politics/2018/01/30/trump-in-first-state-union-talks-safe-strong-and-proud-america-live-blog.html",
  url_image:"//a57.foxnews.com/media2.foxnews.com/BrightCove/694940094001/2018/01/31/0/0/694940094001_5722915923001_5722845190001-vs.jpg?ve=1",
  description:"Trump, in first State of the Union, talks 'safe, strong and proud America",
  publication_date:"2018-01-31T01:01:34Z",
  tweet_count: 404,
  tweet_timeframe: "16",
  total_reach: "3208768",
  total_impression: "3657263",
  total_retweet: "278",
  trump_emotions: {
    "sadness": 0.495333,
    "joy": 0.467605,
    "fear": 0.088724,
    "disgust": 0.128676,
    "anger": 0.135365
  },
  article_emotions: {
    "sadness": 0.495333,
    "joy": 0.467605,
    "fear": 0.088724,
    "disgust": 0.128676,
    "anger": 0.135365
  },
  trump_sentiment: [ -0.74758, "negative"],
  article_sentiment: [ -0.74758, "negative"]
  )


fox_article2 = Article.create!(
  daily_analysis: daily_analysis,
  medium:media1_fox,
  title: "Porn star Stormy Daniels denies affair with Donald Trump",
  author: "Fox News",
  url:"http://www.foxnews.com/entertainment/2018/01/30/porn-star-stormy-daniels-denies-affair-with-donald-trump.html",
  url_image:"//a57.foxnews.com/images.foxnews.com/content/fox-news/entertainment/2018/01/30/porn-star-stormy-daniels-denies-affair-with-donald-trump/_jcr_content/par/featured_image/media-0.img.jpg/0/0/1517360628953.jpg?ve=1",
  description:"Fox News Porn star Stormy Daniels denies affair with Donald Trump Fox. Daniels who had previously alleged an extramarital affair with Donald…",
  publication_date:"2018-01-31T01:08:58Z",
  tweet_count: 404,
  tweet_timeframe: "16",
  total_reach: "3208768",
  total_impression: "3657263",
  total_retweet: "278",
  trump_emotions: {
    "sadness": 0.495333,
    "joy": 0.467605,
    "fear": 0.088724,
    "disgust": 0.128676,
    "anger": 0.135365
  },
  article_emotions: {
    "sadness": 0.495333,
    "joy": 0.467605,
    "fear": 0.088724,
    "disgust": 0.128676,
    "anger": 0.135365
  },
  trump_sentiment: [ -0.74758, "negative"],
  article_sentiment: [ -0.74758, "negative"]
  )

fox_article3 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media1_fox,
  title: "Trump overheard saying he is '100 percent' behind releasing surveillance memos",
  author: "Lukas Mikelionis",
  url:"http://www.foxnews.com/politics/2018/01/31/trump-100-percent-behind-releasing-surveillance-memo-tells-gop-lawmaker.html" ,
  url_image: "//a57.foxnews.com/media.foxbusiness.com/BrightCove/854081161001/201801/443/0/0/854081161001_5722802349001_5722758651001-vs.jpg?ve=1",
  description: "President Donald Trump was overheard telling a GOP lawmaker Tuesday night that he’s “100 percent” behind releasing a classified Republican intelligence memo detailing alleged surveillance abuses.",
  publication_date: "2018-01-31T05:24:12Z",
  tweet_count: 404,
  tweet_timeframe: "16",
  total_reach: "3208768",
  total_impression: "3657263",
  total_retweet: "278",
  trump_emotions: {
    "sadness": 0.495333,
    "joy": 0.467605,
    "fear": 0.088724,
    "disgust": 0.128676,
    "anger": 0.135365
  },
  article_emotions: {
    "sadness": 0.495333,
    "joy": 0.467605,
    "fear": 0.088724,
    "disgust": 0.128676,
    "anger": 0.135365
  },
  trump_sentiment: [ -0.74758, "negative"],
  article_sentiment: [ -0.74758, "negative"]
  )

p "Done!"
