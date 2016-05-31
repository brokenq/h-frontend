path = require 'path'
fs = require 'fs'

module.exports = (env)->
  env = env or process.env.NODE_ENV or 'local'
  profilePath = path.join __dirname, "../env", "#{env}.json"
  return console.warn "profile file not exist : #{profilePath}" if !fs.existsSync profilePath
  conf = JSON.parse fs.readFileSync( profilePath, 'utf-8' )
  Object.keys( conf ).forEach (key) ->
    process.env[ key ] = conf[ key ]
