ActiveAdmin.register Follower do
  permit_params :name, :reviewed, :nickname
  actions :all
  index do
    selectable_column
    id_column
    column :name
    column :nickname
    column :reviewed
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :nickname
      f.input :reviewed
    end
    f.actions
  end

end
