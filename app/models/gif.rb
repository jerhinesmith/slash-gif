class Gif < ActiveRecord::Base
  acts_as_taggable

  # Validations
  validates :external_id, :url, presence: true

  # Callbacks
  before_validation :ensure_external_id, on: :create

  # Scopes
  scope :recent, -> { order(id: :desc) }

  def self.random(tags = [])
    if id = (tags.blank? ? self : self.tagged_with(tags, any: true)).pluck(:id).sample
      find(id)
    else
      message = tags.blank? ? "No gifs found" : "Couldn't find Gif with tag(s) #{tags.join(', ')}"
      raise ActiveRecord::RecordNotFound, message
    end
  end

  def available?
    begin
      response = Net::HTTP.get_response(URI.parse(url))
      response.code == '200'
    rescue Errno::ECONNREFUSED => e
      false
    end
  end

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
