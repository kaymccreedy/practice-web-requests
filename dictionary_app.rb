require "http"

system "clear"
puts "Kay's Dictionary App"
puts "Enter 'q' to exit."
while true
  puts "Enter a word:"
  word = gets.chomp.downcase
  unless word == "q"
    response = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=YOURAPIKEYHERE")

    response_audio = HTTP.get("https://api.wordnik.com/v4/word.json/rabbit/audio?useCanonical=false&limit=50&api_key=YOURAPIKEYHERE")

    data = response.parse(:json)
    unless data.include?("error") 
      x = 0
      while true
        if data[x]["text"] != nil
          definition = data[x]["text"].gsub('<em>', '').gsub('</em>', '')
          puts "\n#{word} (#{data[x]["partOfSpeech"]})\n"
          puts "definition:\t#{definition}\n\n"
          break
        else
          x += 1
        end
      end
    else
      puts "\nWord not found.  Try again.\n\n"
    end
  else
    break
  end
end

      # x = 0
      # while true
      #   if data[x]["exampleUses"] != nil
      #     if data[x]["exampleUses"].length != 0
      #       puts "example:\t'#{data[x]["exampleUses"][0]["text"]}'"
      #       break
      #     end
      #   else
      #     if x < data.length
      #       x += 1
      #     else
      #       break
      #     end
      #   end
      # end
      # puts "Enter 'listen' to hear the word pronounced."
      # puts "Enter anything else to go again."
      # answer = gets.chomp.downcase
      # if answer == "listen"
      #   system "open #{response_audio.parse(:json)[0]["fileUrl"]}"
      # end