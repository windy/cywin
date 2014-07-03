require 'spec_helper'

describe InviteCode do

  it ".generate ok" do
    ic = create(:invite_code)
    expect { InviteCode.generate(1) }.to change { InviteCode.count }.by(1)
  end

  it ".generate max" do
    ic = create(:invite_code)
    expect { InviteCode.generate(1999) }.to change { InviteCode.count }.by(1999)
  end

  it ".generate max" do
    ic = create(:invite_code)
    expect { InviteCode.generate(2000) }.to change { InviteCode.count }.by(0)
  end
end
