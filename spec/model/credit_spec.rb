require 'rails_helper'
describe Credit do
  describe '#create' do
    it "is valid " do
      credit = build(:credit)
      expect(credit).to be_valid
    end

    it "is invalid without card_number" do
      credit = build(:credit, card_number: "")
      credit.valid?
      expect(credit.errors[:card_number]).to include("can't be blank")
    end

    it "is invalid with a duplicate card_number" do
      credit = create(:credit)
      another_credit = build(:credit)
      another_credit.valid?
      expect(another_credit.errors[:card_number]).to include("has already been taken")
    end

    it "is invalid without expiration_month" do
      credit = build(:credit, expiration_month: "")
      credit.valid?
      expect(credit.errors[:expiration_month]).to include("can't be blank")
    end

    it "is invalid with a expiration_month that has more than 13" do
      credit = build(:credit, expiration_month: "13")
      credit.valid?
      expect(credit.errors[:expiration_month]).to include("must be less than or equal to 12")
    end

    it "is invalid without expiration_year" do
      credit = build(:credit, expiration_year: "")
      credit.valid?
      expect(credit.errors[:expiration_year]).to include("can't be blank")
    end

    it "is invalid without security_code" do
      credit = build(:credit, security_code: "")
      credit.valid?
      expect(credit.errors[:security_code]).to include("can't be blank")
    end

    it "is invalid with a duplicate security_code" do
      credit = create(:credit)
      another_credit = build(:credit)
      another_credit.valid?
      expect(another_credit.errors[:security_code]).to include("has already been taken")
    end

  end
end
