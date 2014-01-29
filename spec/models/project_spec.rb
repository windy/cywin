require 'spec_helper'

describe Project do
  it "logo should be presence" do
    expect { create(:project) }.not_to raise_error
  end

  it "members need" do
    pending
  end
end
