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
require 'rails_helper'

RSpec.describe Content, type: :model do
  it 'is valid with a title and body' do
    content = build(:content)
    expect(content).to be_valid
  end

  it 'is invalid without a title' do
    content = build(:content, title: nil)
    expect(content).not_to be_valid
    expect(content.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without a body' do
    content = build(:content, body: nil)
    expect(content).not_to be_valid
    expect(content.errors[:body]).to include("can't be blank")
  end
end
