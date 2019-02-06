require 'rails_helper'
describe Adress do
  describe '#create' do
    it "is valid" do
      adress = build(:adress)
      expect(adress).to be_valid
    end

    it "is invalid without first_name" do
      adress = build(:adress, first_name: "")
      adress.valid?
      expect(adress.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without last_name" do
      adress = build(:adress, last_name: "")
      adress.valid?
      expect(adress.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without first_name_kana" do
      adress = build(:adress, first_name_kana: "")
      adress.valid?
      expect(adress.errors[:first_name_kana]).to include("can't be blank")
    end

    it "is invalid without last_name_kana" do
      adress = build(:adress, last_name_kana: "")
      adress.valid?
      expect(adress.errors[:last_name_kana]).to include("can't be blank")
    end

    it "is invalid without postal_code" do
      adress = build(:adress, postal_code: "")
      adress.valid?
      expect(adress.errors[:postal_code]).to include("can't be blank")
    end

    it "is invalid without prefecture" do
      adress = build(:adress, prefecture: "")
      adress.valid?
      expect(adress.errors[:prefecture]).to include("can't be blank")
    end

    it "is invalid without city" do
      adress = build(:adress, city: "")
      adress.valid?
      expect(adress.errors[:city]).to include("can't be blank")
    end

    it "is invalid without street" do
      adress = build(:adress, street: "")
      adress.valid?
      expect(adress.errors[:street]).to include("can't be blank")
    end

    it "is invalid without building_name" do
      adress = build(:adress, building_name: "")
      adress.valid?
      expect(adress.errors[:building_name]).to include("can't be blank")
    end

    it "is invalid without tel" do
      adress = build(:adress, tel: "")
      adress.valid?
      expect(adress.errors[:tel]).to include("can't be blank")
    end

  end
end
