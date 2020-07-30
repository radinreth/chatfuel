module SettingsHelper
  def bot_status_html(telegram_bot)
    return '' unless telegram_bot.persisted?

    icon_class = telegram_bot.actived? ? 'fa-check-circle text-success' : 'fa-times-circle text-danger'
    icon_title = telegram_bot.actived? ? t('telegram_bot.valid_bot') : t('telegram_bot.invalid_bot')

    "<span class='ml-1'><i class='far #{icon_class}' data-toggle='tooltip' title='#{icon_title}'></i></span>"
  end
end
