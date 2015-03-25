# Description
#   A hubot script to ask questions
#
# Author:
#   tily <tidnlyam@gmail.com>

module.exports = (robot) ->
  callbacks = {}

  currentCallback = (user, callback)->
    callbacks[user.id] ||= {}
    if callback
      callbacks[user.id][user.room] = callback
    else
      callback = callbacks[user.id][user.room]
      callbacks[user.id][user.room] = null
      callback

  robot.ask = (envelope, question, callback)->
    robot.reply envelope, question
    currentCallback(envelope.user, callback)

  robot.respond /(.+)/, (message)->
    if callback = currentCallback(message.message.user)
      callback(message)
      message.done = true
