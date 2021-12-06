# frozen_string_literal: true

module Api
  module V1
    class ListsController < ApplicationController
      def index
        @lists = List.search(params['q'])&.map(&:attributes)&.map do |list|
          model = List.find(list['id'])
          list.merge('ready_to_turn_default_gacha' => model.ready_to_turn_default_gacha?,
                     'ready_to_turn_price_gacha' => model.ready_to_turn_price_gacha?,
                     'ready_to_turn_calorie_gacha' => model.ready_to_turn_calorie_gacha?)
        end
        render json: @lists
      end

      def show
        @list = List.is_public.find_by(id: params[:id])
        if @list.present?
          render json: @list
        else
          render json: { errors: { title: 'リストが非公開、もしくは存在していません。' } }, status: :bad_request
        end
      end
    end
  end
end
