module SitesHelper
  def popover_html(site)
    num = "#{ENV.fetch('NUMBER_OF_SYNC_LOG') { 5 }}".to_i - 1
    dom = '<ul class="list-group list-group-flush">'
    dom += site.sync_logs.slice(0.."#{num}".to_i).map { |log| sync_log_html(log) }.join('')
    dom +='</ul>'
    dom
  end

  private
    def sync_log_html(sync_log)
      "<li class='list-group-item'><span>#{I18n.l(sync_log.created_at, format: :long)}<span> :<span class='ml-1 #{sync_log.status == 'success' ? 'text-success' : 'text-danger'}'>#{sync_log.status}</span></li>"
    end
end
