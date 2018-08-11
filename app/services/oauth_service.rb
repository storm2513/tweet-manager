class OauthService
  class << self
    def find_or_create_user(auth_hash)
      user = User.where(uid: auth_hash.uid).first_or_create
      user.update(
        nickname: auth_hash.info.nickname,
        image: auth_hash.info.image,
        token: auth_hash.credentials.token,
        secret: auth_hash.credentials.secret
      )
      user
    end
  end
end
