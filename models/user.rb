class User
  include DataMapper::Resource

  property :id, Serial
  property :token, String
  property :domain, String
  property :email, String
  property :password, String

  before :valid?, :assign_domain
  before :create, :generate_token

  validates_presence_of :domain, :email, :password
  # validate :authenticated_with_harvest

  def self.first_or_create(params)
    if existing = first(:email => params[:email])
      existing.authenticate(params[:password])
    else
      new_user(params)
    end
  end

  def self.new_user(params)
    user = create(params)
    if user.valid?
      user
    end
  end

  def authenticate(given_password)
    if password == given_password
      self
    end
  end

  def assign_domain
    self.domain = "vigetlabs"
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64(5)
  end

end
