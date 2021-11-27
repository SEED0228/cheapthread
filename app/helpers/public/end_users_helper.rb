# frozen_string_literal: true

module Public
  module EndUsersHelper
    def count_create_lists(end_user)
      end_user.lists.where(is_public: true).count
    end
  end
end
