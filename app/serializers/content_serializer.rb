# == Schema Information
#
# Table name: contents
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_contents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ContentSerializer < ActiveModel::Serializer
  attributes :title, :body, :created_at, :updated_at
end
