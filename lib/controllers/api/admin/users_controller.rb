# frozen_string_literal: true

class Api::Admin::UsersController < Api::Admin::BaseController
  def index
    meta, users = paginate(User.all)

    render_jsonapi users, type: :user_list, meta: meta
  end
end
