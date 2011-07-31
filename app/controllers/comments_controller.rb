class CommentsController < ApplicationController
  def create
    begin
      @music = Music.find(params[:music_id])
      @new_comment = @music.add_comment(params[:content], session[:user_id])

      respond_to do |format|
        if @music.save
          format.html { redirect_to listen_url, :id => @music.id }
          format.js { @music
                      @new_comment }# render :js => "alert('hello#{ @rend }!!');" }
        else
          format.html { redirect_to listen_url, :alert => 'Comment could not be processed'}
          format.js { render :js => "$('#comments').append('<p>This comment could not be processed!</p>')" }
        end
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to home_url, :alert => 'Music_id not found.'
    end
  end

  def destroy
    respond_to do |format|
      begin
        @comment = Comment.find(params[:id])

        if @comment.user.id == session[:user_id]
          @comment.destroy

          format.html { redirect_to listen_url, :id => @comment.music.id }
          format.js { render :js => "$(\".comment[data-value='#{ @comment.id }']\").hide('slow');" }
        else
          format.html { redirect_to home_url, :alert => 'You are not the author of this comment.' }
          format.js { render :js => "alert('You are not the author of this comment');" }

        end

      rescue ActiveRecord::RecordNotFound
        format.html { redirect_to home_url, :alert => 'Comment not found'}
        format.js { render :js => "alert('Comment not found');" }
      end
    end
  end

  def update
    respond_to do |format|
      begin
        @comment = Comment.find(params[:id])

        if @comment.user.id != session[:user_id]
          format.html { redirect_to listen_url, :id => @comment.music.id }
          format.js { render :js => "alert('You are not the author of this comment.');" }
        else
          @comment.update_attribute(:content, params[:content])
          if @comment.save
            format.html { redirect_to listen_url, :id => @comment.music.id }
            format.js { @music = @comment.music
                        @new_comment = @comment}
          else
            format.html { redirect_to listen_url, :id => @comment.music.id, :notice => 'Comment could not be edited.' }
            format.js { render :js => "alert('Comment could not be edited.');"  }
          end
        end
      rescue ActiveRecord::RecordNotFound
        format.html { redirect_to home_url, :alert => 'Comment not found' }
        format.js { render :js => "alert('Comment not found.');" }
      end

    end
  end
end
