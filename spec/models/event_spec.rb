require 'spec_helper'

describe Event do
  it "const actions 定义" do
    expect(Event::PROJECT_CREATE).to eq('project_create')
  end
end
