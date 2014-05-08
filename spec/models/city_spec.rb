require 'spec_helper'

describe City do
  it "创建成功" do
    expect { create(:city) }.not_to raise_error
  end
end
