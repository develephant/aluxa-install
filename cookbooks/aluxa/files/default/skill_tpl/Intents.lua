--===========================================================================--
--== Aluxa Skill
--== Use this file to process incoming Alexa Intents
--== (c)2016 C. Byerley
--===========================================================================--
--== This is a required file for a skill: skill/Intents.lua

--== Create an empty `skill` object
local skill = {}

--== Add the `launch` listener. This is run the first time a client
--== interacts with your skill or calls your skill without any additional
--== voice instruction.
--== This event recieves an `alexa` object, and the `LauchRequest` from Alexa.
--== See docs for more detailed information.
skill.LaunchIntent = function(alexa, LaunchRequest)
  alexa.tell('Welcome')
end

--== Add an `IntentRequest` listener.
--== You name your functions based on the Intent names your using for your
--== skill. For example to process the intent name `HelloIntent`, we simple
--== create that as the listener method.
--== This event recieves an `alexa` object, and the `IntentRequest` from Alexa.
--== See docs for more detailed information.
skill.HelloIntent = function(alexa, IntentRequest)
  alexa.tell('How are you today?')
end

--== The "SessionEndedRequest" from the Alexa service.
--== You will receive this message when the session ends.
--== A "reason" is passed that explains what prompted the event.
--== Example reason: USER_INITIATED
--== This event recieves a `reason` string, and the `SessionEndedRequest` from Alexa.
--== See docs for more detailed information.
skill.EndIntent = function(reason, EndRequest)
  log('ended: '..reason)
end

--== Return the `skill` object to the Aluxa Server
return skill
