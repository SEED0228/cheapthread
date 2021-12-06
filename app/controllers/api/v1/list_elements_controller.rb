# frozen_string_literal: true

module Api
  module V1
    class ListElementsController < ApplicationController
      before_action :set_list
      def index
        if @list.present?
          render json: @list.list_elements
        else
          render json: { errors: { title: 'リストが非公開、もしくは存在していません。' } }, status: :bad_request
        end
      end

      private

      def set_list
        @list = List.is_public.find_by(id: params[:list_id])
      end
    end
  end
end
