class MessengerController < Messenger::MessengerController
  def webhook
    head :ok
  end
end
