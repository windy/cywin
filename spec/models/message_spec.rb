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

  it "#treated" do
    @user = create(:user)
    message = create(:message_must_action, user: @user)
    expect(@user.messages.untreat.size).to eq(1)
    expect { message.done }.to change { @user.messages.treated.size }.by(1)
  end

  it "#unread_or_must_action" do
    @user = create(:user)
    message = create(:message, user: @user)
    expect { @user.mark_all_as_read }.to change { @user.messages.unread_or_must_action.size }.by(-1)
    message = create(:message_must_action, user: @user)
    expect(@user.messages.unread_or_must_action.size).to  eq(1)
    @user.mark_all_as_read
    message.done
    expect(@user.messages.unread_or_must_action.size).to  eq(0)
  end

end
