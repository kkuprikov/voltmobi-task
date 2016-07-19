class Task < ApplicationRecord
  belongs_to :user
  mount_uploader :document, DocumentUploader

  validates :name, presence: true

  include Workflow
  workflow do
    state :new do
      event :start,   transitions_to: :started
    end

    state :started do
      event :finish,   transitions_to: :finished
    end

    state :finished 
  end

  def image_attached?
    document.content_type.start_with? 'image' if document
  end
end
