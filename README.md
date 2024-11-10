# BCC Minigames

> For developers looking to add some fun mini-games to their RedM project, this script is a great option. It features a collection of API-based games, including rock paper scissors, lock picking, and skill checks, which can be easily integrated into your RedM project. These mini-games can add an extra layer of interactivity and enjoyment to your project, and help engage your users in new and exciting ways. Give it a try and see how it can enhance your development process!

## Features
1. Rock paper scissors
2. Lock picking
3. skillcheck
4. HammerTime
5. Milker
6. 3d Dice Roll

## Installation
1. Download the latest release `bcc-minigames.zip` at [/releases/latest](https://github.com/BryceCanyonCounty/bcc-minigames/releases/latest)
2. Extract and place `minigames` into your `resources` folder
3. Add `ensure bcc-minigames` to your `server.cfg` file
4. Restart your server (unless you have nightly restarts)

## API Docs 

### 3d Dice Roller

Video:

![3ddice-ezgif com-video-to-gif-converter (4)](https://github.com/user-attachments/assets/12fb6889-825d-4a77-bd91-db27f5ff573f)

Example:
**Notions:** 
The notation argument can accept the following roll formats

- simple string notation described as 'number of dice' + 'd' + 'number of sides on the die'. e.g.: `5d6` rolls five six-sided dice.
- an array of string notation. e.g.: `{'2d10','2d6'}`
- a Roll Object as described above. e.g.:`{qty = 5, sides = 10}`
- an array of Roll Objects. e.g.:`{{qty = 2, sides = 10},{qty = 1, sides = 6}}`
- a mixed array of Roll Objects and string notation. e.g.:`{{qty = 2, sides = 10},'2d8'}`

**Supported Dice**
"d4","d6","d8","d10","d12","d20","d100"

```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('rollDice', function(args, rawCommand)
    local cfg = {
        focus = false,  -- Should minigame take nui focus
        cursor = false, -- Should minigame have cursor  (required for lockpick)
        type = 'roll',
        options = {
            notation = { '4d20', '1d6' }, --options: 
            autoClear = {
                active = true,
                time = 1000
            }
        }
    }

    MiniGame.Start('diceroller', cfg, function(result)
        print("Results", result.data)
        print("type", result.type)

        -- Result.type is a string of the callback type (options: rollComplete, beforeRoll, dieComplete, removeComplete)

    end)
end)

RegisterCommand('addDice', function(args, rawCommand)
    local cfg = {
        type = 'add',
        options = {
            notation = { '4d20', '1d6' },
            autoClear = {
                active = false,
                time = 1000
            }
        }
    }

    MiniGame.Trigger('diceroller', cfg)
end)

RegisterCommand('removeDice', function(args, rawCommand)
    local cfg = {
        type = 'remove',
        options = {
            notation = { rollId = 2 }
        }
    }

    MiniGame.Trigger('diceroller', cfg)
end)

RegisterCommand('rerollDice', function(args, rawCommand)
    -- The notation argument here requires an roll object or an array of roll objects identifying the roll group groupId and die rollId you wish to reroll. Die result objects from previous rolls are valid arguments and can be passed in to trigger a reroll.

    local cfg = {
        type = 'reroll',
        options = {
            notation = {
                dieType = "d20",
                groupId = 0,
                rollId = 0,
                sides = 20,
                theme = "default",
                themeColor = "#33ddff",
                value = 9
            }
        }
    }

    MiniGame.Trigger('diceroller', cfg)
end)

RegisterCommand('clearDice', function(args, rawCommand)
    MiniGame.Trigger('diceroller', { type = 'clear' })
end)
```

### Hammer Time
Minigame that lets you hammer nails to a board

Video:

![hammertime_1-ezgif com-video-to-gif-converter (1)](https://github.com/user-attachments/assets/95ca545e-b75a-4922-be57-0e3ceffebf18)

Example:
```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus (required)
        cursor = true, -- Should minigame have cursor  (required)
        nails = 15, -- How many nails to be hammered
        type = 'dark-wood' -- What color wood to display (light-wood, medium-wood, dark-wood)
    }

    MiniGame.Start('hammertime', cfg, function(result)
        print("Done!", result.result) -- true/false
    end)
end)
```

### Lockpicking

Video:

![lockpick-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/faeba5b9-d06d-4de8-8e40-49bff7a38f40)


Example:
```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus
        cursor = true, -- Should minigame have cursor  (required for lockpick)
        maxattempts = 3, -- How many fail attempts are allowed before game over
        threshold = 10, -- +- threshold to the stage degree (bigger number means easier)
        hintdelay = 500, --milliseconds delay on when the circle will shake to show lockpick is in the right position.
        stages = {
            {
                deg = 25 -- 0-360 degrees
            },
            {
                deg = 0 -- 0-360 degrees
            },
            {
                deg = 300 -- 0-360 degrees
            }
        }
        
    }


    MiniGame.Start('lockpick', cfg, function(result)
        print("Unlocked?", result.unlocked) -- true/false
    end)
end)
```

### SkillCheck

Video:

![skillcheck-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/f341faea-1a83-44c7-899a-fd024010bb4e)


Example:
```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus (required)
        cursor = false, -- Should minigame have cursor
        maxattempts = 3, -- How many fail attempts are allowed before game over
        type = 'bar', -- What should the bar look like. (bar, trailing)
        userandomkey = true, -- Should the minigame generate a random key to press?
        keytopress = 'B', -- userandomkey must be false for this to work. Static key to press
        keycode = 66, -- The JS keycode for the keytopress
        speed = 20, -- How fast the orbiter grows
        strict = false -- if true, letting the timer run out counts as a failed attempt
    }


    MiniGame.Start('skillcheck', cfg, function(result)
        print("Passed?", result.passed) -- true/false
    end)
end)
```

### Rock Paper Scissors

Video:

![rps-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/6177c6b8-08e7-44f8-9b0a-15053e85e437)


Example:
```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus
        cursor = true, -- Should minigame have cursor (required)
        allowretry = false --Allows use to start the minigame over.
    }


    MiniGame.Start('rps', cfg, function(result)
        print("Result?", result.result) -- win, lose, tie
    end)
end)
```

### Cow Milker

```lua
local MiniGame = exports['bcc-minigames'].initiate()
RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus (required)
        cursor = true, -- Should minigame have cursor  (required)
        timer = 30, -- The amount of seconds the game will run for
        minMilkPerSqueez = 0.1,
        maxMilkPerSqueez = 0.4
    }

    MiniGame.Start('cowmilker', cfg, function(result)
        print("Milk Collected!", result.collected) -- true/false
    end)
end)
```
