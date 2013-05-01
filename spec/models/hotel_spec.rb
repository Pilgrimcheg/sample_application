# == Schema Information
#
# Table name: hotels
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  room_description   :text
#  include_breakfast  :boolean
#  price              :float
#  adress             :string(255)
#  star_rate_hotel    :integer
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :string(255)
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Hotel do
  let(:user) {FactoryGirl.create(:user)}
  before {@hotel = user.hotels.build(title: "Hilton", room_description: "Biiiiig Room",include_breakfast: true, price: 566.6, adress:"Smolnaya", star_rate_hotel: 3)}

    subject{@hotel}

    it {should respond_to(:title)}
    it {should respond_to(:room_description)}
    it {should respond_to(:include_breakfast)}
    it {should respond_to(:price)}
    it {should respond_to(:adress)}
    it {should respond_to(:user_id)}
    it {should respond_to(:star_rate_hotel)}
    it {should respond_to(:user)}

   its(:user) { should == user }

    it {should be_valid}

    describe "accesible attributes" do
      it "should not allow access to user_id" do
        expect do
          Hotel.new(user_id: user.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end

    describe "when user_id is not present" do
      before {@hotel.user_id = nil}
      it {should_not be_valid}
    end

    describe "with blank title" do
      before {@hotel.title = " "}
      it {should_not be_valid}
    end

     describe "with blank room_description" do
      before {@hotel.room_description = " "}
      it {should_not be_valid}
    end

    describe "with blank include_breakfast" do
      before {@hotel.include_breakfast = " "}
      it {should_not be_valid}
    end

    describe "with blank price" do
      before {@hotel.price = " "}
      it {should_not be_valid}
    end

    describe "with blank star_rate_hotel" do
      before {@hotel.star_rate_hotel = " "}
      it {should_not be_valid}
    end

    describe "with blank adress" do
      before {@hotel.adress = " "}
      it {should_not be_valid}
    end

     describe "with title that is too long" do
      before {@hotel.title = "a" * 141}
      it {should_not be_valid}
    end

     describe "with room_description that is too long" do
      before {@hotel.room_description = "a" * 1001}
      it {should_not be_valid}
    end

    describe "with price that is float" do
      it "should be invalid" do
        @hotel.price = "fg"
        @hotel.should_not be_valid
    end
    end

    describe "with include_breakfast that is boolean" do
      before {@hotel.include_breakfast =  true || false }
      it {should be_valid}
    end

    describe "with adress that is too long" do
      before {@hotel.adress = "a" * 1001}
      it {should_not be_valid}
    end

    describe "with star_rate_hotel out of range" do
      before {@hotel.star_rate_hotel = 6}
      it {should_not be_valid}
    end

    describe "with star_rate_hotel is integer" do
      before {@hotel.star_rate_hotel = 6.6}
      it {should_not be_valid}
    end

    describe "attached photo" do
      it {should have_attached_file(:photo)}
    end

    describe "attached file photo size" do
      it { should validate_attachment_size(:photo).
                less_than(3.megabytes) }
    end

end

