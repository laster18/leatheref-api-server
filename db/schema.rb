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

ActiveRecord::Schema.define(version: 2020_01_08_155007) do

  create_table "comeets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "message", null: false
    t.string "photo"
    t.integer "like_count", default: 0
    t.bigint "user_id"
    t.string "comeetable_type"
    t.bigint "comeetable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comeetable_type", "comeetable_id"], name: "index_comeets_on_comeetable_type_and_comeetable_id"
    t.index ["user_id"], name: "index_comeets_on_user_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "review_id"
    t.bigint "in_reply_to_id"
    t.text "comment", null: false
    t.boolean "reply", default: false
    t.bigint "in_reply_to_user_id"
    t.integer "like_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["in_reply_to_id"], name: "index_comments_on_in_reply_to_id"
    t.index ["in_reply_to_user_id"], name: "index_comments_on_in_reply_to_user_id"
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "communities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "permittion_level", default: 0
    t.string "symbol_image"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_communities_on_owner_id"
    t.index ["title"], name: "index_communities_on_title", unique: true
  end

  create_table "community_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_community_members_on_community_id"
    t.index ["member_id", "community_id"], name: "index_community_members_on_member_id_and_community_id", unique: true
    t.index ["member_id"], name: "index_community_members_on_member_id"
  end

  create_table "direct_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "room_id"
    t.text "message"
    t.string "image"
    t.integer "data_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_direct_messages_on_room_id"
    t.index ["sender_id"], name: "index_direct_messages_on_sender_id"
  end

  create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_entries_on_room_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "follows", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "target_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_user_id"], name: "index_follows_on_target_user_id"
    t.index ["user_id", "target_user_id"], name: "index_follows_on_user_id_and_target_user_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "join_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "community_id", null: false
    t.text "message", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_join_requests_on_community_id"
    t.index ["user_id"], name: "index_join_requests_on_user_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "comment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "fk_rails_e92b21943f"
    t.index ["user_id", "comment_id"], name: "index_likes_on_user_id_and_comment_id", unique: true
  end

  create_table "product_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_categories_on_name", unique: true
  end

  create_table "reactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_reactions_on_name", unique: true
  end

  create_table "review_pictures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "review_id"
    t.string "picture", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_review_pictures_on_review_id"
  end

  create_table "review_reactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "review_id"
    t.bigint "reaction_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reaction_id"], name: "index_review_reactions_on_reaction_id"
    t.index ["review_id", "reaction_id", "user_id"], name: "index_review_reactions_on_review_id_and_reaction_id_and_user_id", unique: true
    t.index ["review_id"], name: "index_review_reactions_on_review_id"
    t.index ["user_id"], name: "index_review_reactions_on_user_id"
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_name", null: false
    t.text "content", null: false
    t.string "first_picture_url"
    t.integer "price"
    t.integer "rating", null: false
    t.integer "comment_count", default: 0
    t.bigint "user_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_category_id"
    t.index ["product_category_id"], name: "index_reviews_on_product_category_id"
    t.index ["store_id"], name: "index_reviews_on_store_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stores_on_name", unique: true
  end

  create_table "topics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "community_id"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_topics_on_community_id"
    t.index ["owner_id"], name: "index_topics_on_owner_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.string "display_name"
    t.string "login_name", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "provider"
    t.string "image_url"
    t.string "image"
    t.bigint "love_store_id"
    t.text "profile"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login_name"], name: "index_users_on_login_name", unique: true
    t.index ["love_store_id"], name: "index_users_on_love_store_id"
  end

  add_foreign_key "comeets", "users"
  add_foreign_key "comments", "comments", column: "in_reply_to_id"
  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "users", column: "in_reply_to_user_id"
  add_foreign_key "communities", "users", column: "owner_id"
  add_foreign_key "community_members", "communities"
  add_foreign_key "community_members", "users", column: "member_id"
  add_foreign_key "direct_messages", "rooms"
  add_foreign_key "direct_messages", "users", column: "sender_id"
  add_foreign_key "entries", "rooms"
  add_foreign_key "entries", "users"
  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "target_user_id"
  add_foreign_key "join_requests", "communities"
  add_foreign_key "join_requests", "users"
  add_foreign_key "likes", "comments"
  add_foreign_key "likes", "users"
  add_foreign_key "review_pictures", "reviews", on_delete: :cascade
  add_foreign_key "review_reactions", "reactions"
  add_foreign_key "review_reactions", "reviews"
  add_foreign_key "review_reactions", "users"
  add_foreign_key "reviews", "product_categories"
  add_foreign_key "reviews", "stores"
  add_foreign_key "reviews", "users"
  add_foreign_key "topics", "communities"
  add_foreign_key "topics", "users", column: "owner_id"
  add_foreign_key "users", "stores", column: "love_store_id"
end
