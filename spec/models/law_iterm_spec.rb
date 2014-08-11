require 'spec_helper'

describe LawIterm do
  it "#project_law_iterms" do
    expect(LawIterm.project_law_iterms(1)).not_to raise_error
  end
end
