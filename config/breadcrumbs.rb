crumb :root do
  link "Home", root_path
end
crumb :userShow do
  link "マイページ", user_path(current_user.id)
  parent :root
end
crumb :userEdit do
  link "プロフィール", user_path(current_user.id)
  parent :userShow
end
crumb :creditEdit do
  link "支払い方法", credits_path
  parent :userShow
end
crumb :creditNew do
  link "支払い方法", new_credit_path
  parent :creditEdit
end
crumb :adressEdit do
  link "本人情報の登録", new_credit_path
  parent :userShow
end
