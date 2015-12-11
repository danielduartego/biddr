module AuctionsHelper

  def label_class(state)
    case state
    when "published"
      "label-default"
    when "reserve_met"
      "label-primary"
    when "won"
      "label-success"
    when "reserve_not_met"
      "label-danger"
    when "canceled"
      "label-warning"
    end
  end


end
