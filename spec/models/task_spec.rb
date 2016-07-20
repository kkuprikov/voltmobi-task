require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task)             { create(:task) }
  let(:task_with_image)  { create(:task_with_image) }

  it "has a valid factory" do
    expect(build(:task)).to be_valid
  end

  it "is invalid without name" do
    expect(build(:task, name: '')).to_not be_valid
  end

  it "checks image_attached?" do
    task_with_image
    expect(task_with_image.image_attached?).to eq(true)
  end

  it "checks image_attached? false" do
    task_no_doc
    expect(task_no_doc.image_attached?).to eq(false)
  end

  it "checks image_attached? false 2" do
    task
    expect(task.image_attached?).to eq(false)
  end
end
