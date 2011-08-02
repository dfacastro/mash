class DownloadsController < ApplicationController
  skip_before_filter :authorize
  def get

    begin
      @music = Music.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to home_url, :alert => 'sMash not found.'}
        format.js { render :js => "alert('sMash not found.');" }
      end
      return
    end


    unless session[:user_id]
      #existem registos anteriores deste IP
      begin
        @download = Download.find_by_ip!(request.remote_ip)

        if (Time.now - @download.updated_at) < (20*60) #delay of 20 mins between downloads
          respond_to do |format|
            format.html {redirect_to listen_url, :id => @music.id, :notice => (20 - (Time.now - @download.updated_at)/60).to_s + ' minutes left until your next download is available. Register for limitless downloads.' }
            format.js { render :js => "alert('" + (20 - (Time.now - @download.updated_at)/60).to_s + " minutes left until your next download is available. Register for limitless downloads.');" }
          end
          return
        end

        @download.music = @music
      #nao existem registos anteriores
      rescue ActiveRecord::RecordNotFound
        @download = Download.new(:ip => request.remote_ip, :music => @music)
      end

      @download.save
      @id = @download.id
      respond_to do |format|
        format.html { redirect_to download_path(:dl_id => @id)}
        format.js { render :js => "window.location.href = '" + download_path(:dl_id => @id) + "';"}
      end
      return
    end

    respond_to do |format|
      format.html { redirect_to download_path(:dl_id => @id) }
      format.js { render :js => "window.location.href = '" + download_path(:music_id => @music.id) + "';"}
    end

  end

  def download
    if session[:user_id]
      @music = Music.find(params[:music_id])
      send_file 'public/saved/' + @music.filename, :type => 'audio/mpeg', :disposition => 'attachment'
    else
      @download = Download.find(params[:dl_id])
      send_file 'public/saved/' + @download.music.filename, :type => 'audio/mpeg', :disposition => 'attachment'
    end
  end

end
