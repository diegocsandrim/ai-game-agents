# ai-game-agents
Artificial intelligence in computer games homework

## Dependencies
- LÖVE 0.10.2 [Get it here](https://love2d.org/)

Check with the command `love --version` (It must say something like _LOVE 0.10.2 (Super Toast)_)

## How to run it

Download the code, and enter in the folder. It is easier if you have git, [get git here](https://git-scm.com/downloads):
```
git clone https://github.com/diegocsandrim/ai-game-agents.git
cd ai-game-agents
```

From your command line run:
```
# running the train simulation
love train

# running the game
love capture-the-flag
```

## Train simulation

### Train
There file `./train/parameter.lua` has all available parameters for the the train simulation.
- param.debug -> starts the app in debug mode, showing the influence map
- param.velocity -> initial velocity

- param.person.quantity -> ammount of person
- param.person.influence -> person influence
- param.person.minStaticInfluence -> min influence the person will consider for moving
- param.person.influenceDist -> how much distance the person influence propagates
- param.person.influenceDecay -> how fast the person influence decay

- param.seat -> seat parameters, with influence, influenceDist and influenceDecay

- param.wall -> wall parameters, with influence, influenceDist and influenceDecay

- param.platform -> platform (outside of the train) parameters, with influence, influenceDist and influenceDecay

- param.stand -> stand places (inside the train) parameters, with influence, influenceDist and influenceDecay

- param.influence.size.x -> width of influence map, changing this value is not currently suported
- param.influence.size.y -> width of influence map, changing this value is not currently suported

### Capture the flag
There is no config
