class Broadcast < ActiveRecord::Base
    after_save { string.sub("[",""),
     self.save}
end
