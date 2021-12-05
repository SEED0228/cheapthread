# frozen_string_literal: true

module Api
  module V1
    class GachasController < ApplicationController
      before_action :set_list
      def default
        if @list.present?
          if (num = params[:num].to_i).positive? && @list.ready_to_turn_default_gacha?
            render json: @list.turn_default_gacha(num)
          else
            render json: { errors: { title: '入力が不正です' } }
          end
        else
          render json: { errors: { title: 'リストが非公開、もしくは要素を持たないもの、もしくは存在していません。' } }
        end
      end

      def price
        if @list.present?
          if (price = params[:price].to_i).positive? && @list.ready_to_turn_price_gacha?
            render json: @list.turn_price_gacha(price)
          else
            render json: { errors: { title: '入力が不正、もしくはガチャができないリストです' } }
          end
        else
          render json: { errors: { title: 'リストが非公開、もしくは要素を持たないもの、もしくは存在していません。' } }
        end
      end

      def calorie
        if @list.present? && @list.contains_calorie
          if (calorie = params[:calorie].to_i).positive? && @list.ready_to_turn_calorie_gacha?
            render json: @list.turn_calorie_gacha(calorie)
          else
            render json: { errors: { title: '入力が不正、もしくはガチャができないリストです' } }
          end
        else
          render json: { errors: { title: 'リストが非公開、もしくは要素を持たないもの、もしくは存在していません。' } }
        end
      end

      private

      def set_list
        @list = List.is_public.contains_elements.find_by(id: params[:list_id])
      end
    end
  end
end
