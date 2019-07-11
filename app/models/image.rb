class Image < ApplicationRecord
    mount_uploader :image, ItemImageUploader
end
                         