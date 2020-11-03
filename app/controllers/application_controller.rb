# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pagy::Backend
  include Pundit

  before_action :authenticate_user_with_guisso!
  before_action :set_raven_context
  before_action :switch_locale

  private
    def user_not_authorized
      flash[:alert] = t("not_authorized")
      redirect_to(request.referrer || root_path)
    end

    def switch_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def set_raven_context
      Raven.user_context(id: session[:current_user_id])
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def set_daterange
      @start_date = params["start_date"] || default_start_date
      @end_date = params["end_date"] || default_end_date
    end

    def default_end_date
      Date.current.strftime('%Y/%m/%d')
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def filter_options
      {
        province_id: params['province_code'],
        district_id: compact_district_codes,
        start_date: @start_date,
        end_date: @end_date,
        platform: params[:platform],
        gender: params[:gender]
      }.with_indifferent_access
    end

    def compact_district_codes
      Array.wrap(params['district_code']).compact_blank
    end

    def set_location_filter
      @location_filter = LocationFilter.new(province_filter, district_filter)
    end

    def province_filter
      return unless filter_options['province_id'].present?

      ::Filters::ProvinceFilter.new(filter_options['province_id'])
    end

    def district_filter
      return unless filter_options['district_id'].present?

      ::Filters::DistrictFilter.new(filter_options['district_id'])
    end
end
