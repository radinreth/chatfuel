# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    @setting = Setting.first || Setting.new
  end

  def template
    @setting = Setting.find_or_initialize_by(id: setting_params[:id])
    if @setting.update(setting_params)
      redirect_to settings_path, flash: { notice: "successfully updated message template" }
    else
      flash.now[:alert] = "cannot update message template"
      render :index
    end
  end

  private
    def setting_params
      params.require(:setting).permit(:id, :incompleted_text, :completed_text, :incompleted_audio, :completed_audio)
    end
end
