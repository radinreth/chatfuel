# frozen_string_literal: true

module Sites
  class ApiKeysController < ApplicationController
    before_action :set_site

    def show
    end

    def update
      if @site.regenerate_token
        flash[:notice] = I18n.t("sites.generate_api_success")
      else
        flash[:alert] = @site.errors.full_messages
      end

      redirect_to site_api_key_path(@site)
    end

    private
      def set_site
        @site = Site.find(params[:site_id])
      end
  end
end
