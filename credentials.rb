require 'yaml'

class Credentials
  attr_accessor :email, :password
  
  def initialize
    config = YAML.load_file('credentials.yml')
    self.email = config['email']
    self.password = config['password']
  end
end