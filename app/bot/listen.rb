require "facebook/messenger"
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
Bot.on :message do |message|
  faq = {
    "I want to purchase items" => "ok which items you want?",
    "give me options" => "Sure here are they.\n 1) fashion jewellery and 2) crafts.",
    "1" => "1) Necklaces\n2) Earrings",
    "2" => "Product1 with price Rs. 100",
    "final" => "Booked your order. Thank you for shopping."
  }
  msg = message.text
  if faq[message.text]
    msg = faq[message.text]
  else
    msg = "Did you mean? I want to purchase item ?"
  end
  Bot.deliver({
    recipient: message.sender,
    message: {
      text: msg
    }
  }, access_token: ENV["ACCESS_TOKEN"])
end