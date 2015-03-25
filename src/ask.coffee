# Description
#   A hubot script to ask questions
#
# Author:
#   tily <tidnlyam@gmail.com>

module.exports = (robot) ->
  callbacks = {}

  currentCallback = (user, room, callback)->
    callbacks[user.id] ||= {}
    if callback
      callbacks[user.id][room.id] = callback
    else
      callback = callbacks[user.id][room.id]
      callbacks[user.id][room.id] = null
      callback

  robot.ask = (question, callback, message)->
    if message
      message.reply(question)
    else
      robot.send question
    currentCallback(user, room, callback)

  robot.respond /(.+)/, (message)->
    if callback = currentCallback(message.message.user.id, message.message.room.id)
      callback(message)
      message.done = true
