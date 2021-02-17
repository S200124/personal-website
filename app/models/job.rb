class Job < ApplicationRecord

  belongs_to :address
  belongs_to :profile

  def human_from
    human_date(from)
  end

  def human_to
    if(to > Date.today)
      "today"
    else
      human_date(to)
    end
  end

  def human_date(date)
    "#{'%02i' % date.month}/#{date.year}"
  end
end
