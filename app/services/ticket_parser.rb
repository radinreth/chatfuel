require "oj"

class TicketParser
  def initialize(hash)
    @hash = hash
  end

  def to_json
    hash = @hash.gsub("=>", ":")
    ticket_attrs = Oj.load(hash) || []

    ticket_attrs.map do |hash|
      att = {}
      mapping_column.each do |key, value|
        att[key] = hash[value]
      end

      return att
    end
  end

  private
    def mapping_column
      {
        code: "TicketID",
        service_description: "ServiceDescription",
        status: "Status",
        requested_date: "RequestedDate",
        approval_date: "ApprovalDate",
        delivery_date: "DeliveryDate",
        dist_gis: "DistGis",
        tell: "Tell"
      }
    end
end
