module Features
  def default_messageboard
    @messageboard ||= create(:messageboard, site: default_site)
  end

  def default_user
    @user ||= create(:user, password:'password', password_confirmation:'password')
  end

  def default_site
    @default_site ||= create(:site, default_site: true, user: default_user)
  end

  def sign_in_with_default_user
    visit '/users/sign_in'
    fill_in 'Email', with: default_user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  def sign_out
    visit '/users/sign_out'
  end

  def sign_in_with(email, password)
    visit '/users/sign_in'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end

  def page!
    save_and_open_page
  end

  alias create_default_messageboard default_messageboard
  alias create_default_user default_user
  alias create_default_site default_site
end
