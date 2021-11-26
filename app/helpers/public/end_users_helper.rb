module Public::EndUsersHelper
    def count_create_lists(end_user)
        return end_user.lists.where(is_public: true).count
    end
end
