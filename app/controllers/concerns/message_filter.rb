class MessageFilter
  def self.before(controller)
    if controller.action_name == "done"
      controller.send(:get_message)
    else
      controller.send(:set_message)
    end
  end
end
