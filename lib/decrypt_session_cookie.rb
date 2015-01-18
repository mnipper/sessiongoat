puts "Value for _sessiongoat_session:\n"
encrypted_session_value = gets.chomp 

unescaped_content = CGI.unescape(encrypted_session_value)

secret = Rails.application.key_generator.generate_key('encrypted cookie')
sign_secret = Rails.application.key_generator.generate_key('signed encrypted cookie')

encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret, serializer: JSON)
decrypted_hash = encryptor.decrypt_and_verify(unescaped_content)

puts "Decrypted hash is:\n\n #{decrypted_hash}\n\n"
