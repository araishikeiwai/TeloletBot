require 'telegram/bot'
require 'redis'
load 'init.rb'

redis = Redis.new

telolet = [
  'Telolet telolelolet telolet tet',
  'Tettett tolelot lolelolet telolelolet',
  'Tooot lelolelot tolet lolelolelolet tet',
  'Telolet tet tet tet',
  'Lolelolet teet telolelolet telolet',
  'Tet tet lolelolet tet telolet tet tet teet teeeeet',
  'Tet tet lolelolet teet telolet lolet telolelolet',
  'Teet tet tet telolelolelololelolelolet',
  'Teeeeet lolelolelolelet'
]
begin
  Telegram::Bot::Client.run($token) do |bot|
    bot.listen do |message|
      if message.text =~ /te+lo+le+t/i
        redis.incr(:telolet_message_count)
        redis.sadd(:telolet_users, message.chat.id)
        bot.api.send_message(chat_id: message.chat.id, text: telolet[rand(telolet.size)], reply_to_message_id: message.message_id)
      end
    end
  end
rescue
  retry
end
