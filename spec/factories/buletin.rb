# t.string   "title"
# t.string   "content_type"
# t.string   "filename"
# t.integer  "size"
# t.datetime "date_time"
# t.boolean  "ninos"
# t.datetime "created_at"
# t.datetime "updated_at"
############
### buletin
############
Factory.define :buletin_one, :class => Buletin do |u|
  u.title "Test"
  u.content_type "application/pdf"
  u.filename "test.pdf"
  u.size "102282"
  u.created_at Time.now
  u.updated_at Time.now
  u.date_time Time.now
end
