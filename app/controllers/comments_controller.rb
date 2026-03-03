class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to event_path(@event), notice: 'Commentaire publié.'
    else
      redirect_to event_path(@event), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path, notice: 'Commentaire supprimé.'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
