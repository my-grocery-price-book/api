unless ENV['MUTANT']
  SimpleCov.start do
    add_filter 'vendor/bundle'
  end
  SimpleCov.minimum_coverage 100
end
