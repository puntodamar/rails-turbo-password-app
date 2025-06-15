class Entry < ApplicationRecord
    validates :name, :url, :username, :password, presence: true
    validate :url_must_be_valid
    belongs_to :user

    encrypts :username, deterministic: true
    encrypts :password


    private

    def url_must_be_valid
        uri = URI.parse(url) rescue nil
        unless uri&.scheme.in?(%w[http https])
            errors.add(:url, :invalid)  # will use your locale “invalid” message
        end
    end

    def self.search(params)
        data = self
        if params.present?
            if params["name"].present?
                data = self.where("name ILIKE :name", name: "%#{params[:name]}%")
            end
        else
            data = self.all
        end

        data.order(:name)
    end
end
