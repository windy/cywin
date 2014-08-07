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

  it ".validate_code" do
    expect(InviteCode.validate_code(111111)).to be_false
    ic = create(:invite_code)
    expect(InviteCode.validate_code('000001')).to be_true
  end

  it ".mark_used" do
    ic = create(:invite_code)
    InviteCode.mark_used('000001')
    expect(ic.reload.used).to be_true
  end
end
