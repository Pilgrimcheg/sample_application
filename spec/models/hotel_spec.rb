require 'spec_helper'

describe Hotel do
  let(:user) {FactoryGirl.create(:user)}
  before {@hotel = user.hotels.build(title: "Hilton", room_description: "Biiiiig Room",include_breakfast: "false", price: 566.6, adress:"Smolnaya")}

    subject(@hotel)

    it {should respond_to(:title)}
    it {should respond_to(:room_description)}
    it {should respond_to(:include_breakfast)}
    it {should respond_to(:price)}
    it {should respond_to(:adress)}
    it {should respond_to(:user_id)}
    it {should respond_to(:user)}

    its(:user) { should == user }

    /it {should be_valid}/

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

end

