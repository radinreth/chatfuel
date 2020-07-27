# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    @telegram_bot = TelegramBot.first || TelegramBot.new
  end

  def set_language
    Setting.default_locale = params[:locale]

    head :ok
  end

  def telegram_bot
    @telegram_bot = TelegramBot.find_or_initialize_by(id: telegram_bot_params[:id])

    if @telegram_bot.update(telegram_bot_params)
      flash[:notice] = I18n.t("settings.successful_update_bot")
    else
      flash[:alert] = I18n.t("settings.failure_update_bot")
    end

    redirect_to settings_path
  end

  private
    def telegram_bot_params
      params.require(:telegram_bot).permit(:id, :username, :token)
    end
end
