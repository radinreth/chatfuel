module SitesHelper
  def popover_html(site)
    num = "#{ENV.fetch('NUMBER_OF_SYNC_LOG') { 5 }}".to_i - 1
    dom = '<ul class="list-group list-group-flush">'
    dom += site.sync_logs.first(num).map.with_index { |log, index| sync_log_html(log, index) }.join('')
    dom +='</ul>'
    dom
  end

  private
    def sync_log_html(sync_log, index)
      dom = "<li class='list-group-item p-1'>"
      dom += "<span>#{index+1}. #{I18n.l(sync_log.created_at, format: :y_m_d_h_mn)} - </span>"
      dom += "<span class='ml-1 sync-status #{sync_log.success? ? 'text-success' : 'text-danger'}'>#{sync_log.status}</span>"
      dom += "<span>(success: #{sync_log.success_count}, failed: #{sync_log.failure_count})</span>"
      dom += "</li>"
      dom
    end
end
