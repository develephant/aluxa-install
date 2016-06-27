# Aluxa Server/SDK

__A Lua based framework and server for working with the Amazon Alexa service.__

## Introduction

__Aluxa__ is both a server and SDK that uses the Lua language to quickly create __Amazon Alexa__ "skills" for personal or production use.

The __Aluxa Server__ runs on the enterprise level [Nginx](https://www.nginx.com/) app server. The __Aluxa SDK__ is a simple [Lua](http://www.lua.org/docs.html) framework, allowing for rapid development.

An __Aluxa Server__ can be generated into a number of deployment formats, or quickly "spun up" using pre-built [__Amazon EC2 AMIs__]().

## Amazon Alexa Service

Please make yourself familiar with the __Alexa Service__ and the __Alexa__ developer portal by referencing the following documents, at minimum.

  - [Getting Started with the Alexa Skills Kit](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/getting-started-guide)
  - [Registering and Managing Custom Skills in the Developer Portal](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/registering-and-managing-alexa-skills-in-the-developer-portal)
  - [Implementing the Built-in Intents](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/implementing-the-built-in-intents)
  - [Providing Home Cards for the Amazon Alexa App](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/providing-home-cards-for-the-amazon-alexa-app)
  - [Testing a Custom Skill](https://developer.amazon.com/appsandservices/solutions/alexa/alexa-skills-kit/docs/testing-an-alexa-skill)
  - [JSON Interface Reference for Custom Skills](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/alexa-skills-kit-interface-reference)

## Requirements

 * A current __Alexa__ device (Echo, Dot, or Tap).
 * __Amazon Web Services__ account with admin access.
 * A fully qualified domain name (FQDN) that you control.
 * A valid email address to register for SSL certificates.

__On your computer you will need:__

 * The program [Vagrant](https://www.vagrantup.com) if you are going to do local development. ___You can not test on a device in local mode___. But you can test Aluxa server requests using a tool like [Postman](https://www.getpostman.com/).
 * The program [Packer](https://www.packer.io/intro/) if you plan to generate images for various services.
 * An __SFTP__ program to manage your "skill" project files.
 * A __Command Line__ program to manage your server with.

## Installation

To install __Aluxa Server__ you can use one of the [pre-generated __Amazon EC2__ images](), or generate a Droplet "image" in your __[DigitalOcean](https://m.do.co/c/cddeeddbbdb8)__ account. You can also run a "local" version for development with __[Vagrant](https://www.vagrantup.com)__.

You can find instructions for each deployment type in their respective folders. For example, see `/deploy/digitalocean/README.md` for a __DigitalOcean__ image creation guide.

> Image creation is powered by __[Packer](https://www.packer.io/intro/)__ and __[Chef](http://chef.github.io/)__. You can find other services that Packer can create images for on the [Packer](https://www.packer.io/intro/platforms.html) website and easily create new deployment types.

### Log In

Once you spin up your first image, you can log in from the command line:

```shell
ssh aluxa@aluxa.domain.com
```
> The default password is `admin`. Change it after log in by entering `passwd` on the command line.

### SSL

On your first launch of a hosted image, you need to generate some secure certificates. __The Amazon Alexa service will only accept `https://` requests__. Log in to your instance and issue the following:

```shell
sudo certbot-auto certonly --standalone
```
Confirm the update, and follow the on screen instructions to generate the certificates.

## Getting Started

Once you have logged in to your __Aluxa Server__ you can access the Aluxa tools. The following functions are available. Type `aluxa` without any "action" for the most up to date functions.

```shell
[sudo] aluxa <action> [parameter]
```

|Action|Parameter|Sudo|Description|
|------|---------|----|-----------|
|`status`|-|N|Reports the server run status.|
|`logs`|-|N|Start tailing the aluxa.log|
|`skills`|-|N|List the current skills.|
|`start`|-|Y|Start the Aluxa Server process.|
|`stop`|-|Y|Stop the Aluxa Server process.|
|`reload`|-|Y|Reload the Aluxa Server process.|
|`renew`|-|Y|Force a certificate expiration check.|
|`cert`|-|N|Echo a copy of your self-signed cert.|
|`skill`|skill name (string)|Y|Initialize a new skill.|
|`delete`|skill name (string)|Y|Removes a current skill.|

## Alexa Skills

When you first launch an instance, a demo "skill" is pre-installed called `hello`. It can be found in the `/home/aluxa/skills` directory.

```shell
cd /home/aluxa/skills/hello
```

Inside this directory is a basic "skill" project:

```shell
/hello
  api.lua
  Intents.lua
```

> The `api.lua` is almost never edited. It merely provides the bootstrap into the Aluxa Server process, but is a required file none the less.

---

### `Intents.lua`

The `Intents.lua` is where you will work on your __Alexa__ skill functionality. The file is a collection of "listeners" that will trigger based on incoming __Alexa__ requests.

__Alexa Request Lifecycle__

  1. A speech based request is made to an __Alexa__ compatible device.
  1. The request is sent to __Amazon__, then routed to your __Aluxa Server__.
  1. You process the message depending upon type and event state.
  1. A structured response object is sent back to __Amazon__.
  1. The message is processed and rendered through the __Alexa__ device.
  1. Optionally, the session is left open for a consumer response.

__Alexa Intents__

There are basically 3 major request types for __Alexa__ intents; `LaunchRequest`, `IntentRequest`, and `SessionEndedRequest`.

A __LaunchRequest__ is triggered when a user has newly launched your skill, or is addressing your skill with no additional voice parameters. You will generally receive this event once per session. This is a good time to gather the user, session, and application ID from the `LaunchRequest` table object that is passed in.

Using the __Aluxa SDK__, a launch request can be handled like so:

```lua
--skills/hello/Intents.lua
local skill = {}

function skill.LaunchIntent(alexa, LaunchRequest)
  local userId, sessionId, appId
  userId = LaunchRequest.getUserId()
  sessionId = LaunchRequest.getSessionId()
  appId = LaunchRequest.getApplicationId()

  -- Optional; put the meta in a Mongo datastore

  alexa.tell('Hello!')
end

...

return skill
```

Along with the incoming "request" object, we also get a reference to the `alexa` response object. This object has two methods we can use to send back a response. They only differ in how they leave the session state; either open for more user input, or closed, in effect ending the transaction.

---

The __SessionEndedRequest__ signals that the skill session has been closed by some method, which is reported to the listener through the `reason` parameter. There is no reference to the `alexa` response object at this phase. Though you can reference the SessionEndedRequest object to do any clean up based on session, user, or application ID. In the SDK it looks like:

```lua
--skills/hello/Intents.lua
local skill = {}

...

function skill.EndIntent(reason, EndedRequest)
  local sessionId = EndedRequest.getSessionId()

  log('session done '..reason)
end

...

return skill
```

---

The final, and most important request type is the __IntentRequest__. This request holds all other request types, custom types included. The request object contains a "type" which was assigned by the __Alexa__ service based on the user input.

To listen for these "intents" we simply create a "listener" method with the intent type. For example, for an Intent with a type of `HelloIntent` we write the following using the SDK:

```lua
--skills/hello/Intents.lua
local skill = {}

...

function skill.HelloIntent(alexa, IntentRequest)
  alexa.tell('Well howdy to you too.')
end

...

return skill
```

If the skill contains multiple intent types, we register them seperatly. For example, if a new intent named `GoodbyeIntent` is added to the skill, we can listen for it as well:

```lua
--skills/hello/Intents.lua
local skill = {}

...

function skill.HelloIntent(alexa, IntentRequest)
  alexa.tell('Well howdy to you too')
end

function skill.GoodbyeIntent(alexa, IntentRequest)
  alexa.tell('Lets talk soon')
end

...

return skill
```

All together, a skill file might look something like this:

```lua
--skills/hello/Intents.lua
local skill = {}

function skill.LaunchIntent(alexa, LaunchRequest)
  alexa.tell('Hello!')
end

function skill.HelloIntent(alexa, IntentRequest)
  alexa.tell('Well howdy to you too')
end

function skill.GoodbyeIntent(alexa, IntentRequest)
  alexa.tell('Lets talk soon')
end

function skill.EndIntent(reason, EndedRequest)
  log('session ended '..reason)
end

return skill
```

## `alexa` Response

Both `LaunchRequest` and `IntentRequest` pass in a reference to the `alexa` response object. This object has only two methods. The main difference being how the "session" state is left after a transaction.

If the session state is left open, the consumer can respond to the last sent request. When the session state is closed, no more communication can take place until the next invocation of your skill.

__Response types__

### `alexa.tell`

##### `alexa.tell( speech[, attr][, card][, type] )`

Sends a message to the consumer, closing the session.

__Parameters__

|Name|Description|Required|
|----|-----------|--------|
|`speech`|The text to be spoken to the consumer.|Y|
|`attr`|Associative table of attributes.|N|
|`card`|A card object. See "Using Cards" below.|N|
|`type`|The speech input type (PlainText,SMXL).|N|

### `alexa.ask`

##### `alexa.ask( speech, prompt[, attr][, card][, type] )`

Sends a message to the consumer, leaving the session open for consumer response.

__Parameters__

|Name|Description|Required|
|----|-----------|--------|
|`speech`|The text to be spoken to the consumer.|Y|
|`prompt`|Text spoken when consumer delays.|Y|
|`attr`|Associative table of attributes.|N|
|`card`|A card object. See "Using Cards" below.|N|
|`type`|The speech input type (PlainText,SMML).|N|

## Using Cards

Cards are displayed on the __Alexa__ mobile app and are associated to the request made. Displaying a card is optional. A Card has a specfic structure and methods as outlined below:

### `Card.new([type])`

```lua
local Card = require('aluxa.card')
local c = Card.new()
```

__Parameters__

|Name|Description|Default|Required|
|----|-----------|-------|--------|
|`type`|The `Card` type displayed on the device. [Simple](), [Standard](), or [LinkAccount](). (string)|Simple|N|

__Returns__

A new `Card` object instance.

__Instance Methods__

#### `card:setTitle(string)`

The title to display on the Card.

#### `card:setText(string)`

The text to display on the Card.

#### `card:setSmallImageUrl(stringUrl)`

Sets and loads a "small" version of the specified Card image.

#### `card:setLargeImageUrl(stringUrl)`

Sets and loads a "large" version of the specified Card image.

#### `card:setType(cardType)`

The `type` of Card to display. Defaults to 'Simple'. Other options: 'Standard', 'LinkAccount'.

#### `card:get()`

Return the meta data associated with this Card instance.

Cards can be passed to the consumer with an `alexa` response:

```lua
...

function skill.HelloIntent(alexa)
  local Card = require('aluxa.card')
  local c = Card.new()
  c:setTitle("Here comes the Sun")
  c:setText("Its going to be a great day!")

  alexa.tell("Its going to be a great day", nil, c:get())
end

...
```

## Request Objects

The __Aluxa Server__ will take incoming request types and format then into a usable table object in Lua. All three major request types share a common set of methods, and each one individually has their own additional methods.

### Shared Request Methods

These methods are shared across all request types (Launch, Intent, Ended).

|Method|Description|
|------|-----------|
|`getVersion`|Returns __Alexa Service__ version.|
|`getRequest`|Returns the `request` table.|
|`getSession`|Returns the `session` table.|
|`isNewSession`|Returns the session state.|
|`getSessionId`|Returns the current session ID.|
|`getApplication`|Returns the `application` table.|
|`getApplicationId`|Returns the application identifier.|
|`getAttributes`|Returns the `attributes` table, if any.|
|`getUserId`|Returns the current skill users ID.|
|`getUser`|Returns the `user` table.|
|`getRequestType`|The current __Alexa__ request type.|
|`getRequestId`|Returns the current request ID.|
|`getRequestTimestamp`|Returns the timestamp for the request.|

#### IntentRequest Extended

|Method|Description|
|------|-----------|
|`getRequestIntent`|Returns the __Alexa__ request intent table.|
|`getRequestIntentName`|Returns the __Alexa__ request intent name.|
|`getRequestIntentSlots`|Retuns any data slots for this request.|

#### SessionEndedRequest Extended

|Method|Description|
|------|-----------|
|`getReason`|Returns the session ended reason string.|

__Example Usage__

```lua
...

function skill.LaunchIntent(alexa, LaunchRequest)
  --log user id
  local uid = LaunchRequest.getUserId()
  log('user '..uid)

  alexa.tell('Hello User')
end

function skill.HelloIntent(alexa, IntentRequest)
  --ref request id
  local id = IntentRequest.getRequestId()
  log('request '..id)

  alexa.tell('Glad to meet you!')
end

...

```
