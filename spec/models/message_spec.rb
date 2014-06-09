require 'spec_helper'

describe Message do

  it "User#mark_all_as_read" do
    @user = create(:user)
    message = create(:message, user: @user)
    expect { @user.mark_all_as_read }.to change { @user.messages.unread.size }.by(-1)
  end

  it "#read" do
    @user = create(:user)
    message = create(:message, user: @user)
    message.mark_as_read()
    expect(message).to be_is_read
  end

end
