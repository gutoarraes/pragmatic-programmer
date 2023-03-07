module UsersHelper
  def profile_image(gravatar_id)
    image_tag("https://secure.gravatar.com/avatar/#{gravatar_id}?s=48", alt: 'Gravatar', class: 'gravatar')
  end
end
