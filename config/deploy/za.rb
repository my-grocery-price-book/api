%w(za_ec za_fs za_gt za_nl za_lp za_mp za_nc za_nw za_wc).each do |za_user|
  server "#{za_user.gsub('_', '-')}.public-grocery-price-book-api.co.za",
         user: za_user, roles: %w(web app)
end
