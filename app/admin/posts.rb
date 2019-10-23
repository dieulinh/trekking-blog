ActiveAdmin.register Post do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  permit_params :title, :post_thumbnails, :category, :description, :is_private

  form partial: 'form'

  show do
    h3 post.title

    div do
      image_tag url_for(post.post_thumbnails.variant(resize: "100x100").processed) if post.post_thumbnails
    end

  end

end
