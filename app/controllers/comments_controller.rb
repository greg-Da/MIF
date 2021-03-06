class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correspondance_validated?, only: [:create]

  # GET /comments
  def index
    @user = User.find(params[:user_id])
    @sent_comments = current_user.authored_comments
    @received_comments = @user.received_comments
    respond_to do |format|
      format.html { redirect_to current_user}
      format.js {}
    end
  end

  # POST /comments
  def create
    content = params[:content]
    @comment = Comment.new(author: current_user, receiver: @other_user, content: content)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @other_user, notice: 'Comment was successfully created.' }
      else

        flash[:danger] =  'Comment was not created.'
        format.html { redirect_to @other_user }
      end
    end
  end


  private

  def correspondance_validated?
    @other_user = User.find(params[:user_id])
    c = Correspondance.select(current_user, @other_user)
    if c == false
      flash[:danger] = "not possible to leave comment if you are not in a correspondance"
      redirect_to current_user
    elsif c.status == "waiting"
      flash[:danger] = "You can not leave a comment if the correspondance is not validated"
      redirect_to current_user
    elsif c.status == "refused"
      flash[:danger] = "You can not leave a comment if the correspondance is refused"
      redirect_to current_user
    end
  end

end
