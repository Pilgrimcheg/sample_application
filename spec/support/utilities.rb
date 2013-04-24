include ApplicationHelper

def valid_signin_authentication(user)
   fill_in "Email", with: user.email
   fill_in "Password", with: user.password
   click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end

 def valid_signin_user_pages(user)
      fill_in "Name", with: "Example User"
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "Foobar"
      fill_in "Confirmation", with: "Foobar"
  end

end