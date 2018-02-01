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

media_fox = Medium.create!(
  name:"Fox News",
  logo:"http://p14.zdassets.com/hc/settings_assets/63348/200430188/Nsmx0VrtWicyK9MvKEUphQ-1024.png",
  url:"http://www.foxnews.com/"
)

media_cnn = Medium.create!(
  name:"CNN",
  logo:"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/CNN.svg/1280px-CNN.svg.png",
  url:"https://edition.cnn.com/"
)

media_nbc = Medium.create!(
  name:"NBC News",
  logo:"https://upload.wikimedia.org/wikipedia/commons/9/9f/NBC_News_2013_logo.png",
  url:"https://www.nbcnews.com/"
)

p "Done!"

p "Creating Daily Analysis!"

daily_analysis = DailyAnalysis.create!(
  fox_global_sentiment: [ -0.342451, "negative"],
  cnn_global_sentiment: [ -0.431977, "negative"],
  nbc_global_sentiment: [ -0,509968, "negative"]
  )

p "Done!"

p "Creating Articles..."

# Fox News Articles

fox_article1 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media_fox,
  title:"Trump, in first State of the Union, talks 'safe, strong and proud America",
  author: "Fox News",
  url:"http://www.foxnews.com/politics/2018/01/30/trump-in-first-state-union-talks-safe-strong-and-proud-america-live-blog.html",
  url_image:"//a57.foxnews.com/media2.foxnews.com/BrightCove/694940094001/2018/01/31/0/0/694940094001_5722915923001_5722845190001-vs.jpg?ve=1",
  description:"Trump, in first State of the Union, talks 'safe, strong and proud America",
  publication_date:"2018-01-31T01:01:34Z",
  tweet_count: 63,
  tweet_timeframe: "16",
  total_reach: "420876",
  total_impression: "365763",
  total_retweet: "27",
  trump_emotions: {
    "sadness": 0.231073,
    "joy": 0.547689,
    "fear": 0.046186,
    "disgust": 0.12283,
    "anger": 0.12294
  },
  article_emotions: {
    "sadness": 0.231073,
    "joy": 0.547689,
    "fear": 0.046186,
    "disgust": 0.12283,
    "anger": 0.12294
  },
  trump_sentiment: [ 0.244299, "positive"],
  article_sentiment: [ 0.244299, "positive"]
  )


fox_article2 = Article.create!(
  daily_analysis: daily_analysis,
  medium:media_fox,
  title: "Porn star Stormy Daniels denies affair with Donald Trump",
  author: "Fox News",
  url:"http://www.foxnews.com/entertainment/2018/01/30/porn-star-stormy-daniels-denies-affair-with-donald-trump.html",
  url_image:"//a57.foxnews.com/images.foxnews.com/content/fox-news/entertainment/2018/01/30/porn-star-stormy-daniels-denies-affair-with-donald-trump/_jcr_content/par/featured_image/media-0.img.jpg/0/0/1517360628953.jpg?ve=1",
  description:"Fox News Porn star Stormy Daniels denies affair with Donald Trump Fox. Daniels who had previously alleged an extramarital affair with Donald…",
  publication_date:"2018-01-31T01:08:58Z",
  tweet_count: 177,
  tweet_timeframe: "24",
  total_reach: "777643",
  total_impression: "799397",
  total_retweet: "63",
  trump_emotions: {
    "sadness": 0.471739,
    "joy": 0.158178,
    "fear": 0.102435,
    "disgust": 0.432424,
    "anger": 0.113279
  },
  article_emotions: {
    "sadness": 0.471739,
    "joy": 0.158178,
    "fear": 0.102435,
    "disgust": 0.432424,
    "anger": 0.113279
  },
  trump_sentiment: [ -0.524072, "negative"],
  article_sentiment: [ -0.524072, "negative"]
  )

fox_article3 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media_fox,
  title: "Trump overheard saying he is '100 percent' behind releasing surveillance memos",
  author: "Lukas Mikelionis",
  url:"http://www.foxnews.com/politics/2018/01/31/trump-100-percent-behind-releasing-surveillance-memo-tells-gop-lawmaker.html" ,
  url_image: "//a57.foxnews.com/media.foxbusiness.com/BrightCove/854081161001/201801/443/0/0/854081161001_5722802349001_5722758651001-vs.jpg?ve=1",
  description: "President Donald Trump was overheard telling a GOP lawmaker Tuesday night that he’s “100 percent” behind releasing a classified Republican intelligence memo detailing alleged surveillance abuses.",
  publication_date: "2018-01-31T05:24:12Z",
  tweet_count: 40,
  tweet_timeframe: "16",
  total_reach: "320878",
  total_impression: "367263",
  total_retweet: "17",
  trump_emotions: {
    "sadness": 0.509123,
    "joy": 0.413531,
    "fear": 0.459823,
    "disgust": 0.502183,
    "anger": 0.213321
  },
  article_emotions: {
    "sadness": 0.509123,
    "joy": 0.413531,
    "fear": 0.459823,
    "disgust": 0.502183,
    "anger": 0.213321
  },
  trump_sentiment: [ -0.293302, "negative"],
  article_sentiment: [ -0.293302, "negative"]
  )

p "Fox News articles done!"

#CNN Articles

cnn_article1 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media_cnn,
  title:"Trump squares off with a (new) FBI director",
  author: "Stephen Collinson",
  url:"https://www.cnn.com/2018/02/01/politics/donald-trump-fbi-justice-department-memo/index.html",
  url_image:"http://cdn.cnn.com/cnnnext/dam/assets/180123121443-02-christopher-wray-super-tease.jpg",
  description:"President Donald Trump has already canned one FBI director.",
  publication_date:"2018-02-01T06:42:43Z",
  tweet_count: 35,
  tweet_timeframe: "3",
  total_reach: "269572",
  total_impression: "338665",
  total_retweet: "4",
  trump_emotions: {
    "sadness": 0.518863,
    "joy": 0.170809,
    "fear": 0.149525,
    "disgust": 0.469727,
    "anger": 0.210818
  },
  article_emotions: {
    "sadness": 0.518863,
    "joy": 0.170809,
    "fear": 0.149525,
    "disgust": 0.469727,
    "anger": 0.210818
  },
  trump_sentiment: [ -0.71352, "negative"],
  article_sentiment: [ -0.71352, "negative"]
  )

cnn_article2 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media_cnn,
  title:"FBI clashes with Trump over Russia memo",
  author: "CNN",
  url:"http://www.cnn.com/collections/intl---russian-memo-0201/",
  url_image:"",
  description:"FBI clashes with Trump over Russia memo",
  publication_date:"2018-02-01T03:52:37Z",
  tweet_count: 18,
  tweet_timeframe: "6",
  total_reach: "115892",
  total_impression: "116200",
  total_retweet: "1",
  trump_emotions: {
    "sadness": 0.302157,
    "joy": 0.179591,
    "fear": 0.21056,
    "disgust": 0.061668,
    "anger": 0.043208
  },
  article_emotions: {
    "sadness": 0.302157,
    "joy": 0.179591,
    "fear": 0.21056,
    "disgust": 0.061668,
    "anger": 0.043208
  },
  trump_sentiment: [ -0.74758, "negative"],
  article_sentiment: [ -0.794074, "negative"]
  )

cnn_article3 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media_cnn,
  title:"President Trump opts out of Super Bowl interview",
  author: "Brian Stelter",
  url:"http://money.cnn.com/2018/01/31/media/super-bowl-trump/index.html",
  url_image:"http://i2.cdn.turner.com/money/dam/assets/180131222915-trump-780x439.jpg",
  description:"President Trump has decided not to participate in a Super Bowl Sunday interview this weekend.",
  publication_date:"2018-02-01T03:37:10Z",
  tweet_count: 437,
  tweet_timeframe: "7",
  total_reach: "2201655",
  total_impression: "3335735",
  total_retweet: "397",
  trump_emotions: {
    "sadness": 0.194739,
    "joy": 0.594246,
    "fear": 0.114471,
    "disgust": 0.514366,
    "anger": 0.088407
  },
  article_emotions: {
    "sadness": 0.194739,
    "joy": 0.594246,
    "fear": 0.114471,
    "disgust": 0.514366,
    "anger": 0.088407
  },
  trump_sentiment: [ 0.165169, "positive"],
  article_sentiment: [ 0.165169, "positive"]
  )

p "CNN Articles done!"

nbc_article1 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media_nbc,
  title:"Pence jabs Pelosi, vows Trump will aid GOP",
  author: "Jonathan Allen",
  url:"https://www.nbcnews.com/politics/politics-news/criticizing-pelosi-pence-launches-white-house-midterm-fray-n843546",
  url_image:"https://media4.s-nbcnews.com/j/newscms/2018_05/2312801/180131-mike-pence-ac-828p_f19b295a2fa54901a5f56a6947c0854b.nbcnews-fp-1200-630.jpg",
  description:"In ripping Nancy Pelosi, VP Mike Pence signals that he and President Donald Trump are ready to get into the hand-to-hand combat of congressional elections.",
  publication_date:"2018-02-01T02:59:46Z",
  tweet_count: 54,
  tweet_timeframe: "8",
  total_reach: "122915",
  total_impression: "122932",
  total_retweet: "5",
  trump_emotions: {
    "sadness": 0.558138,
    "joy": 0.483258,
    "fear": 0.062646,
    "disgust": 0.489411,
    "anger": 0.486188
  },
  article_emotions: {
    "sadness": 0.558138,
    "joy": 0.483258,
    "fear": 0.062646,
    "disgust": 0.489411,
    "anger": 0.486188
  },
  trump_sentiment: [ -0.491915, "negative"],
  article_sentiment: [ -0.491915, "negative"]
  )


nbc_article2 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media_nbc,
  title:"Trump was sent an altered Russia memo, Schiff says",
  author: "Alex Johnson",
  url:"https://www.nbcnews.com/politics/politics-news/schiff-says-white-house-was-sent-altered-russia-memo-n843556",
  url_image:"https://media4.s-nbcnews.com/j/newscms/2018_05/2312891/180131-adam-schiff-devin-nunes-2017-ac-1127p_99a8215b4e9f53ab10221215459bf22b.nbcnews-fp-1200-630.jpg",
  description:"Top Democrat on the House Intelligence Committee said the memo the White House is reviewing isn't the one the committee Republicans voted to release.",
  publication_date:"2018-02-01T04:44:00Z",
  tweet_count: 100,
  tweet_timeframe: "2",
  total_reach: "230374",
  total_impression: "235908",
  total_retweet: "190",
  trump_emotions: {
    "sadness": 0.439248,
    "joy": 0.54549,
    "fear": 0.125948,
    "disgust": 0.52079,
    "anger": 0.193706
  },
  article_emotions: {
   "sadness": 0.439248,
    "joy": 0.54549,
    "fear": 0.125948,
    "disgust": 0.52079,
    "anger": 0.193706
  },
  trump_sentiment: [ -0.422047, "negative"],
  article_sentiment: [ -0.422047, "negative"]
  )


nbc_article3 = Article.create!(
  daily_analysis: daily_analysis,
  medium: media_nbc,
  title:"Stormy Daniels appears to deny denial of Trump affair",
  author: "Alex Johnson",
  url:"https://www.nbcnews.com/news/us-news/stormy-daniels-appears-deny-denial-trump-affair-n843131",
  url_image:"https://media3.s-nbcnews.com/j/newscms/2018_03/2295566/180117-stormy-daniels-ew-1244p_356770550107cd0c10ca94aff91298bf.nbcnews-fp-1200-630.jpg",
  description:"The adult film star said on \"Jimmy Kimmel Live\" that she didn't know where a denial of an affair with Donald Trump came from earlier Tuesday.",
  publication_date:"2018-01-31T05:54:59Z",
  tweet_count: 138,
  tweet_timeframe: "24",
  total_reach: "1368309",
  total_impression: "1381833",
  total_retweet: "58",
  trump_emotions: {
    "sadness": 0.453624,
    "joy": 0.538471,
    "fear": 0.109856,
    "disgust": 0.166249,
    "anger": 0.123337
  },
  article_emotions: {
    "sadness": 0.453624,
    "joy": 0.538471,
    "fear": 0.109856,
    "disgust": 0.166249,
    "anger": 0.123337
  },
  trump_sentiment: [ -0.615943, "negative"],
  article_sentiment: [ -0.615943, "negative"]
  )

p "NBC Articles done !"
p "Finished seeding!"
