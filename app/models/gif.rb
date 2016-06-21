class Gif < ActiveRecord::Base
  acts_as_taggable

  # Validations
  validates :external_id, :url, presence: true

  # Callbacks
  before_validation :ensure_external_id, on: :create

  # Scopes
  scope :recent, -> { order(id: :desc) }

  private
  def ensure_external_id
    self.external_id = generate_external_id if self.external_id.blank?

    # return true
    true
  end

  def generate_external_id
    loop do
      external_id = Base64.encode64(SecureRandom.uuid)[0..10]
      break external_id unless self.class.exists?(external_id: external_id)
    end
  end
end
