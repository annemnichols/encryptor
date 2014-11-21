class Encryptor

	def cipher(rotation)
		characters = (' '..'z').to_a
		offset_characters = characters.rotate(rotation)
		pairs = characters.zip(offset_characters)
		Hash[pairs]

	end

	def encrypt_letter(letter,rotation)
		cipher_for_rotation = cipher(rotation)
		cipher_for_rotation[letter]
	end

	def encrypt(string,rotation)
		letters = string.split('')

		results = letters.collect do |letter|
			encrypted_letter = encrypt_letter(letter, rotation)
		end
			
		results.join

	end

	def decrypt(string, rotation)
		rotation = -(rotation)
		letters = string.split('')

		results = letters.collect do |letter|
			encrypted_letter = encrypt_letter(letter, rotation)
		end

		results.join
	end

  def encrypt_file(filename, rotation)

    # Create the file handle to the input file
    message = File.open(filename, "r")
    # Read the text of the input file
    read_message = message.read
    # Encrypt the text
    encrypted_message = encrypt(read_message, rotation)
    # Create a name for the output file
    encrypted_filename = "#{filename}.encrypted"
    # Create an output file handle
    output_message = File.open(encrypted_filename, "w")
    # Write out the text
    output_message.write(encrypted_message)
    # Close the file
    output_message.close

  end

  def decrypt_file(filename, rotation)
  
    # Create the file handle to the encrypted file
    message = File.open(filename, "r")
    # Read the encrypted text
    read_message = message.read
    # Decrypt the text by passing in the text and rotation
    decrypted_message = decrypt(read_message, rotation)
    # Create a name for the decrypted file
    decrypted_filename = filename.gsub("encrypted", "decrypted")
    # Create an output file handle
    output_message = File.open(decrypted_filename, "w")
    # Write out the text
    output_message.write(decrypted_message)
    # Close the file
    output_message.close

  end

end

e = Encryptor.new

puts "What is the file extension you'd like to encrypt?"
print "> "
file_to_encrypt = gets.chomp
puts "What is the rotation number you'd like?"
print "> "
rotation_number = gets.chomp.to_i

e.encrypt_file(file_to_encrypt, rotation_number)
file_to_decrypt = file_to_encrypt + ".encrypted"
e.decrypt_file(file_to_decrypt, rotation_number)
puts "Encrypted/Decrypted files saved."
