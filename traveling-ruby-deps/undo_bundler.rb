clean_env = Bundler.with_clean_env do
  ENV.to_hash.dup
end
ENV.replace(clean_env)
