require 'spec_helper'

describe "Authentication" do

  subject {page}

  describe "signin page" do
    before {visit signin_path}

    it{should have_selector('h1', text: 'Sign in')}
    it {should have_selector('title', text: 'Sign in')}
    end

    describe "signin" do
      before {visit signin_path}

      describe "with invalid information" do
      before {click_button "Sign in"}

      it {should have_selector('title', text: 'Sign in')}
      it {should have_error_message('Invalid')}
      it {should_not have_link('Profile')}
      it {should_not have_link('Settings')}

      describe "after visiting another page" do
        before {click_link "Home"}
        it {should_not have_selector('div.alert.alert-error')}
      end
    end

     describe "with valid information" do

      let(:user) {FactoryGirl.create(:user)}
      before {sign_in(user)}

      it {should have_selector('title', text: user.name)}

      it {should have_link('Users', href: users_path)}
      it {should have_link('Profile', href: user_path(user))}
      it {should have_link('Settings', href: edit_user_path(user))}
      it {should have_link('Sign out', href: signout_path)}

      it {should_not have_link('Sign in', text: signin_path)}
       describe "follow by signout" do
        before {click_link "Sign out"}
        it {should have_link('Sign in')}
       end
    end
  end


  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) {FactoryGirl.create(:user)}

      describe "when attemping to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
      end

        describe "after signin in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text:'Edit user')
        end

        describe "when signing in again" do
          before do
            delete signout_path
            sign_in(user)
        end

        it "should render the default (profile) page" do
          page.should have_selector('title', text:user.name)
        end
      end

      describe "in the Hotels controller" do

        describe "submitting to the create action" do
          before {post hotels_path}
          specify {response.should redirect_to(signin_path)}
        end

        describe "submitting to the destroy action" do
          before {delete hotel_path(FactoryGirl.create(:hotel))}
          specify {response.should redirect_to(signin_path)}
        end
      end
      end
    end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before {visit edit_user_path(user)}
          it {should have_selector('title', text: 'Sign in')}
        end

        describe "submitting to the update action" do
          before {put user_path(user)}
          specify {response.should redirect_to(signin_path)}
        end

        describe "as wrong user" do
          let(:user) {FactoryGirl.create(:user)}
          let(:wrong_user) {FactoryGirl.create(:user, email:"wrong@example.com")}
          before {sign_in user}

          describe "visiting Users#edit page" do
            before {visit edit_user_path(wrong_user)}
            it { should_not have_selector('title', text: full_title('Edit user'))}
          end

          describe "submitting a PUT request to the Users#update action" do
            before{put user_path(wrong_user)}
            specify {response.should redirect_to(root_path)}
          end
        end

        describe "visiting the user index" do
        before {visit users_path}
          it {should have_selector('title', text: 'Sign in')}
        end
      end
    end

    describe "as non-admin users" do
      let(:user) {FactoryGirl.create(:user)}
      let(:non_admin) {FactoryGirl.create(:user)}

      before{sign_in non_admin}

      describe "submitting a DELETE request to User#destroy action" do
        before {delete user_path(user)}
        specify {response.should redirect_to(root_path)}
      end
    end

    describe "as admin user" do
      let(:admin){FactoryGirl.create(:admin)}
      before {sign_in admin}

      describe "can't delete self by submitting DELETE request to Users#destroy" do
        before {delete user_path(admin)}
        specify {response.should redirect_to(users_path), flash[:error].should =~ /Can not delete own admin account!/i}
      end
    end

  end

end
