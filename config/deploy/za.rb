%w(za_ec za_fs za_gt za_nl za_lp za_mp za_nc za_nw za_wc).each do |za_user|
  server '41.79.78.65', user: za_user, roles: %w(web app)
end
