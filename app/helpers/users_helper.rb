module UsersHelper

  def display_gravatar(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?s=150"
    image_tag(gravatar_url, alt: "Photo of #{user.firstname}", class: "gravatar")
  end
end
