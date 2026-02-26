module UsersHelper
  def user_avatar(user, size: 40)
    # On définit une classe selon la taille demandée
    avatar_class = (size < 50) ? "avatar-nav" : "avatar-profile"
    
    if user.avatar.attached?
      image_tag user.avatar, class: "avatar-image #{avatar_class}"
    else
      image_tag "https://loremflickr.com/150/150/portrait?random=#{user.id}", 
                alt: "avatar random", 
                class: "avatar-image #{avatar_class}"
    end
  end
end