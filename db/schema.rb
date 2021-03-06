# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180202110213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "trump_sentiment"
    t.date "publication_date"
    t.string "author"
    t.bigint "medium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "daily_analysis_id"
    t.integer "tweet_count"
    t.string "tweet_timeframe"
    t.string "total_reach"
    t.string "total_impression"
    t.string "total_retweet"
    t.string "hashtag_cloud", default: [], array: true
    t.string "word_cloud", default: [], array: true
    t.text "trump_emotions"
    t.string "article_sentiment", default: [], array: true
    t.text "article_emotions"
    t.string "url_image"
    t.text "description"
    t.index ["daily_analysis_id"], name: "index_articles_on_daily_analysis_id"
    t.index ["medium_id"], name: "index_articles_on_medium_id"
  end

  create_table "daily_analyses", force: :cascade do |t|
    t.date "day"
    t.integer "rt_global_sentiment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "fox_article_global_emotions"
    t.text "cnn_article_global_emotions"
    t.text "nbc_article_global_emotions"
    t.string "fox_article_global_sentiment", default: [], array: true
    t.string "cnn_article_global_sentiment", default: [], array: true
    t.string "nbc_article_global_sentiment", default: [], array: true
    t.text "fox_trump_global_emotions"
    t.text "cnn_trump_global_emotions"
    t.text "nbc_trump_global_emotions"
    t.string "fox_trump_global_sentiment", default: [], array: true
    t.string "cnn_trump_global_sentiment", default: [], array: true
    t.string "nbc_trump_global_sentiment", default: [], array: true
  end

  create_table "media", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "articles", "daily_analyses"
  add_foreign_key "articles", "media"
end
