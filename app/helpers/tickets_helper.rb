module TicketsHelper
  def status_html(status)
    color = { accepted: 'info', paid: 'secondary', approved: 'primary', rejected: 'danger', delivered: 'success'}

    "<span class='badge badge-pill badge-#{color[status.to_sym]}'>#{status.humanize}</span>"
  end
end
