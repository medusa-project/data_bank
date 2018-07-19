class Datafile < ApplicationRecord
  belongs_to :dataset, optional: false
  before_create { self.web_id ||= generate_web_id }

  WEB_ID_LENGTH = 5

  def to_param
    self.web_id
  end

  ##
  # Generates a guaranteed-unique web ID, of which there are
  # 36^WEB_ID_LENGTH available.
  #
  def generate_web_id
    proposed_id = nil
    while true
      proposed_id = (36 ** (WEB_ID_LENGTH - 1) +
          rand(36 ** WEB_ID_LENGTH - 36 ** (WEB_ID_LENGTH - 1))).to_s(36)
      break unless Datafile.find_by_web_id(proposed_id)
    end
    proposed_id
  end



end
