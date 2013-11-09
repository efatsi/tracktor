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
  validates_with_method :valid_harvest_account

  has n, :projects
  has n, :plants

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

  def valid_harvest_account
    begin
      client.account.who_am_i
      return true
    rescue Harvest::AuthenticationFailed
      [false, "Invalid email password combination"]
    end
  end

  def client
    Harvest.client(domain, email, password)
  end

end
