class StorageManager

  attr_accessor :draft_root, :medusa_root, :tmpdir

  def initialize
    storage_config = Settings.storage.collect(&:to_h)
    root_set = MedusaStorage::RootSet.new(storage_config)
    self.draft_root = root_set.at('draft')
    self.medusa_root = root_set.at('medusa')

    if Settings.tmpdir && Settings.tmpdir != ''
      self.tmpdir = Settings.tmpdir
    else
      self.tmpdir = ENV['TMPDIR']
    end

  end

end