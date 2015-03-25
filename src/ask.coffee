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

  robot.ask = (user, question, callback)->
    robot.reply user: user, question
    currentCallback(user, callback)

  robot.respond /(.+)/, (message)->
    if callback = currentCallback(message.message.user)
      callback(message)
      message.done = true
