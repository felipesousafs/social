class ApiService
  attr_reader :auth_token, :user_email, :base_url, :user_password

  def initialize(user_email, options = {})
    @base_url = 'http://localhost:3001'
    if options[:password].present?
      user = User.find_by_email(user_email)
      if user
        @user_email = user_email
        @user_password = options[:password]
      end
    elsif options[:token].present?
      @user_email = user_email
      @auth_token = options[:token]
    else
      puts 'Password or Token is needed.'
      nil
    end
  end

  def get_token
    url = @base_url + '/users/sign_in.json'
    # request = RestClient.get(url, headers)
    response = RestClient::Request.execute(method: :post, url: url,
                                           payload: sign_in_body)
    puts response.code
    if response.code == 200
      @auth_token = JSON.parse(response.body)['authentication_token']
    else
      nil
    end
  end

  def sign_out
    url = @base_url + '/users/sign_out.json'
    # request = RestClient.get(url, headers)
    response = RestClient::Request.execute(method: :delete, url: url, headers: headers)
    puts response.code
    if response.code == 204
      JSON.parse(response.body)
    else
      nil
    end
  end

  #Gerar um "espelhamento" do usuário no banco da API
  def create_mirror
    url = @base_url + '/users.json'
    # request = RestClient.get(url, headers)
    response = RestClient::Request.execute(method: :post, url: url,
                                           payload: sign_up_body)
    puts response.code
    if response.code == 201
      JSON.parse(response.body)
    else
      nil
    end
  end

  def sign_in_body
    {
      "user":
        {
          "email": @user_email,
          "password": @user_password
        }

    }
  end

  def sign_up_body
    {
      "user":
        {
          "email": @user_email,
          "password": @user_password,
          "password_confirmation": @user_password
        }

    }
  end

  def headers
    {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'X-User-Email': @user_email,
      'X-User-Token': @auth_token
    }
  end

  def create_location(latitude, longitude)
    body = {
      "location":
        {
          "latitude": latitude,
          "longitude": longitude
        }

    }

    url = @base_url + '/locations.json'
    # request = RestClient.get(url, headers)
    response = RestClient::Request.execute(method: :post, url: url,
                                           payload: body, headers: headers)
    puts response.code
    if response.code == 201
      JSON.parse(response.body)
    else
      nil
    end
  end

  def nearby_users
    url = @base_url + '/locations/nearby.json'
    # request = RestClient.get(url, headers)
    response = RestClient::Request.execute(method: :get, url: url, headers: headers)
    puts response.code
    if response.code == 200
      JSON.parse(response.body)
    else
      nil
    end
  end
end