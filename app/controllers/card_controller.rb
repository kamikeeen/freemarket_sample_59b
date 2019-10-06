class CardController < ApplicationController
  require "payjp"
  
  def new
    # user機能実装後コメントアウト部分に変更
    # 現在は１で仮置き
    card = Card.where(user_id: 1)
    # card = Card.where(user_id: current_user.id)

    redirect_to action: "show" if card.exists?
  end

  def pay 
    Payjp.api_key = Rails.application.credentials.PAYJP_PRIVATE_KEY
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(card: params['payjp-token']) 
      # user機能実装後コメントアウト部分に変更
      @card = Card.new(user_id: 1, customer_id: customer.id, card_id: customer.default_card)
      # @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete
    # user機能実装後コメントアウト部分に変更
    card = Card.where(user_id: 1).first
    # card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials.PAYJP_PRIVATE_KEY
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def show
    # user機能実装後コメントアウト部分に変更
    @card = Card.where(user_id: 1).first
    # card = Card.where(user_id: current_user.id).first
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.PAYJP_PRIVATE_KEY
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end
end
