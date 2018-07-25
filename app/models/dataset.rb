class Dataset < ApplicationRecord

  has_many :datafiles, dependent: :destroy

  before_create :set_key

  def set_key
    self.key ||= generate_key
  end

  ##
  # Generates a guaranteed-unique key, of which there are
  # 36^KEY_LENGTH available.
  #
  def generate_key
    proposed_key = nil

    while true

      num_part = rand(10 ** 7).to_s.rjust(7, '0')
      proposed_key = "#{Settings.key_prefix}-#{num_part}"
      break unless self.class.find_by_key(proposed_key)
    end
    proposed_key
  end


end
