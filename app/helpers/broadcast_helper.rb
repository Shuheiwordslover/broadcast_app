module BroadcastHelper
end

  def import
    Broadcast.import(params[:file])
    redirect_to root_url, notice: "Users imported."
  end
