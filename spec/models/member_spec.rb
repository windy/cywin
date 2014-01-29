require 'spec_helper'

describe Member do
  it "avatar" do
    expect { create(:member) }.not_to raise_error
  end
end
