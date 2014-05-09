require 'spec_helper'

describe Category do
  it "创建成功" do
    expect { create(:category) }.not_to raise_error
  end
end
