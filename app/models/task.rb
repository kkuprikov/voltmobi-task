class Task < ApplicationRecord
  belongs_to :user
  mount_uploader :document, DocumentUploader

  validates :name, presence: true

  include Workflow
  workflow do
    state :new do
      event :next,   transitions_to: :started
    end

    state :started do
      event :next,   transitions_to: :finished
    end

    state :finished 
  end
end
