# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    @setting = Setting.first || Setting.new
    @telegram_bot = TelegramBot.first || TelegramBot.new
  end

  def template
    @telegram_bot = TelegramBot.first || TelegramBot.new
    @setting = Setting.find_or_initialize_by(id: setting_params[:id])
    if @setting.update(setting_params)
      redirect_to settings_path, flash: { notice: "successfully updated message template" }
    else
      flash.now[:alert] = "cannot update message template"
      render :index
    end
  end

  def telegram_bot
    @setting = Setting.first || Setting.new
    @telegram_bot = TelegramBot.find_or_initialize_by(id: telegram_bot_params[:id])

    if @telegram_bot.update(telegram_bot_params)
      redirect_to settings_path, flash: { notice: I18n.t("settings.successful_update_bot") }
    else
      flash.now[:alert] = I18n.t("settings.successful_update_bot")
      render :index
    end
  end

  private
    def setting_params
      params.require(:setting).permit(:id, :incompleted_text, :completed_text, :incompleted_audio, :completed_audio)
    end

    def telegram_bot_params
      params.require(:telegram_bot).permit(:id, :username, :token)
    end
end
