# frozen_string_literal: true

module Public
  class CheapThreadsController < Public::Base
    before_action :set_list, only: %i[new create]
    before_action :set_nanj, only: %i[create]

    def index; end

    def show
      @cheap_thread = CheapThread.find_by(id: params[:id])
      if @cheap_thread.present?
        @thread_comments = @cheap_thread.thread_comments
        @thread_comment = ThreadComment.new
      else
        redirect_to root_path, notice: 'このスレは存在しません' unless @cheap_thread.present?
      end
    end

    def create
      @cheap_thread = @list.cheap_threads.new(thread_params)
      set_thread
      if @cheap_thread.save
        redirect_to cheap_thread_path(@cheap_thread), notice: 'スレの作成に成功しました'
      else
        render 'new'
      end
    end

    def new
      @cheap_thread = @list.cheap_threads.new
    end

    private

    def set_list
      @list = List.find_by(id: params[:list_id])
      redirect_to root_path, notice: 'このリストは公開されていない、もしくは存在しません' if @list.nil?
      if !@list.is_public && @list.end_user != current_end_user
        redirect_to root_path,
                    notice: 'このリストは公開されていない、もしくは存在しません'
      end
      redirect_to root_path, notice: 'このリストは要素がありません' unless @list.ready_to_turn_default_gacha?
    end

    def thread_params
      params.require(:cheap_thread).permit(:title, :initial_name)
    end

    def set_thread
      @cheap_thread.nanj_id = @nanj.id
      @cheap_thread.end_user_id = current_end_user.id if current_end_user.present?
      @cheap_thread.initial_name = '風吹けば名無し' if @cheap_thread.initial_name.blank?
    end
  end
end
