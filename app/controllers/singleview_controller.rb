class SingleviewController < ApplicationController
  def index
    @user = Profile.first
    @jobs = @user.jobs
    @exp_years = ((Date.today - @jobs.minimum(:from).to_date).to_f / 365).round(1)
    @degrees = @user.certifications.where("\"to\" < ?", Date.today).order(to: :desc)
  end
end
