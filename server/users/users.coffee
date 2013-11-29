Accounts.onCreateUser (options, user)->
  console.log "Login: ", options, ", User: ", user
  user.group = "dev"
  user.profile = options.profile || {}
  if options.email
    user.profile.email = options.email;

  unless user.profile.name
    user.profile.name = user.username;

  user;
