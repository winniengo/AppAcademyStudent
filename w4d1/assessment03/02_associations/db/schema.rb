# Senators write bills, which we will assume are implicitly endorsed by
# that Senator's Party, as well. 

# Bills can be "endorsed" by other Senators.

# Senators are assigned to work on one or more Committees. 
# The Committee is led by a chairperson (a Senator). 
# Senators can chair at most one Committee, 
#  but can be regular members of several committees.

# Each Senator belongs to a Party. Each Party believes in an Ideology and
# is led by a party leader (a Senator).

# Lastly, Senators have a Desk, where they work.

ActiveRecord::Schema.define(version: 20150502223202) do

  create_table "bill_endorsements", force: true do |t|
    t.integer  "bill_id"
    t.integer  "senator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bills", force: true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "committee_memberships", force: true do |t|
    t.integer  "senator_id"
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "committees", force: true do |t|
    t.string   "name"
    t.string   "mandate"
    t.integer  "chairperson_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "desks", force: true do |t|
    t.string   "model"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideologies", force: true do |t|
    t.string   "name"
    t.string   "direction"
    t.string   "goal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "ideology_id"
    t.integer  "party_leader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "senators", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "state"
    t.integer  "party_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
