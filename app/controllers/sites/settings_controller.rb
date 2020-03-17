# frozen_string_literal: true

module Sites
  class SettingsController < ApplicationController
    before_action :set_site
    def show
      @setting = @site.site_setting
    end

    def new
      @setting = @site.build_site_setting
    end

    def create
      @setting = @site.build_site_setting(site_setting_params)
      if @setting.save
        redirect_to site_setting_path(@site), flash: { notice: I18n.t("sites.succesfully_create_setting") }
      else
        flash.now[:alert] = I18n.t("sites.erorr_create_setting")
        render :new
      end
    end

    def edit
      @setting = @site.site_setting
    end

    def update
      @setting = @site.site_setting
      if @setting.update(site_setting_params)
        redirect_to site_setting_path(@site), flash: { notice: I18n.t("sites.succesfully_update_setting") }
      else
        flash.now[:alert] = I18n.t("sites.erorr_update_setting")
        render :edit
      end
    end

    private
      def set_site
        @site = Site.find(params[:site_id])
      end

      def site_setting_params
        params.require(:site_setting).permit(:id, :message_template, :message_frequency, :digest_message_template)
      end
  end
end
