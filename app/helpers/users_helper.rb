module UsersHelper
  def user_avatar(user, size: 40)
    avatar_class = (size < 50) ? "avatar-nav" : "avatar-profile"
    
    if user.avatar.attached?
      image_tag user.avatar, class: "avatar-image #{avatar_class}"
    else
      # UI Avatars génère une image fixe basée sur le nom (stable au rafraîchissement)
      initials = "#{user.first_name&.first}#{user.last_name&.first}".presence || "U"
      image_tag "https://ui-avatars.com/api/?name=#{initials}&size=#{size}&background=0D6EFD&color=fff", 
                alt: "avatar par défaut", 
                class: "avatar-image #{avatar_class}"
    end
  end
end