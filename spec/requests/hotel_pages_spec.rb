require 'spec_helper'

describe "HotelPages" do

  subject {page}

  let(:user) {FactoryGirl.create(:user)}
  before {sign_in user}

  describe "hotel creation" do
    before {visit root_path}

    describe "with invalid information" do

      it "should not create a hotel" do
        expect {click_button "Post"}.not_to change(Hotel, :count)
      end

      describe "error messages" do
        before {click_button "Post"}
        it {should have_content('error')}
      end
      end

      describe "with valid information" do

        before do
          fill_in 'hotel_title', with: "Lorem ipsum"
          fill_in 'hotel_room_description', with: "Some text"
          check 'hotel_include_breakfast'
          fill_in 'hotel_price', with: 55.2
          fill_in 'hotel_adress', with: "Some adress"
        end

        it "should create a hotel" do
          expect{click_button"Post"}.to change(Hotel, :count).by(1)
        end
    end
  end

  describe "hotel destruction" do
    before {FactoryGirl.create(:hotel, user: user)}

    describe "as correct user" do
      before {visit root_path}

      it "should delete a hotel" do
        expect {click_link "delete"}.to change(Hotel, :count).by(-1)
      end
    end
  end
end
