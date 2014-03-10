require 'spec_helper'

describe Event do
  it "const actions 定义" do
    expect(Event::PROJECT_CREATE).to eq('project_create')
    Event::ACTIONS.each do |m|
      puts m
    end
  end
end
