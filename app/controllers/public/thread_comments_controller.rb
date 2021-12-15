# frozen_string_literal: true

module Public
  class ThreadCommentsController < Public::Base
    before_action :set_nanj, only: %i[create]

    def show; end

    def create
      @cheap_thread = CheapThread.find(params[:cheap_thread_id])
      @thread_comment = @cheap_thread.thread_comments.new(comment_params)
      set_comment
      if @thread_comment.save
        success_process
      else
        redirect_to cheap_thread_path(@cheap_thread), notice: @thread_comment.errors.full_messages.join(',')
      end
      @thread_comments = @cheap_thread.thread_comments
    end

    private

    def comment_params
      params.require(:thread_comment).permit(:comment, :name, :email)
    end

    def set_comment
      @thread_comment.name = @cheap_thread.initial_name if @thread_comment.name.blank?
      @thread_comment.nanj_id = @nanj.id
      @thread_comment.end_user_id = current_end_user.id if current_end_user.present?
      @thread_comment.number = @cheap_thread.comment_number + 1
      @thread_comment.set_user_id
    end

    def success_process
      @cheap_thread.add_comment_number
      add_anker_comments
      flash[:notice] = 'コメントの追加に成功しました'
    end

    def add_anker_comments
      max = @thread_comment.max_anker
      return unless max > @cheap_thread.comment_number

      max += [0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3].sample
      @cheap_thread.create_anker_comments(max)
    end
  end
end
