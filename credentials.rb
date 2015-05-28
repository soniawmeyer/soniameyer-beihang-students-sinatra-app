require 'yaml'

class Credentials
  attr_accessor :email, :password, :access_token
  
  def initialize
    config = YAML.load_file('credentials.yml')
    self.email = config['email']
    self.password = config['password']
    self.access_token = config['access_token']
  end
end