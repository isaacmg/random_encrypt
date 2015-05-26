
require 'rubygems'
require 'encryptor'
require 'net/http'
require 'uri'
class Encrypted 
	def encrypt 
	salt = getRandomNumber.to_s
	# Normally you would mask your key with some environment variable (i.e. ENV['MY_PRIVATE_KEY])
	secret_key = 'samplekey'
	iv = OpenSSL::Cipher::Cipher.new('aes-256-cbc').random_iv
	encrypted_value = Encryptor.encrypt('Sample message', :key => secret_key, :iv => iv, :salt => salt)
	decrypted_value = Encryptor.decrypt(encrypted_value, :key => secret_key, :iv => iv, :salt => salt)
	puts salt 
	puts encrypted_value 
	puts decrypted_value
	end
	def open(url)
 	 Net::HTTP.get(URI.parse(url))
	end
	def getRandomNumber
	# Get entirely random salt from a quantum random generator.
	# See http://qrng.anu.edu.au/index.php
	page_content = open('http://150.203.48.55/RawHex.php')
	page_array = page_content.split(/[\s\:]/)
	trIndex = page_array.find_index("<tr>") 
	xy = trIndex + 2 
	page_array[xy]
	end 
end
Encrypted.new.encrypt
