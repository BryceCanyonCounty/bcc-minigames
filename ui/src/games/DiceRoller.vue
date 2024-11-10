<template>
  <div id="dice-container"></div>
</template>

<script>
import DiceBox from "@3d-dice/dice-box";

export default {
  props: {
    config: { type: Object, required: true }
  },
  emits: ["result"],
  data() {
    return {
      rolling: false,
      autoClear: true,
      autoClearTimout: null,
      autoClearTime: 5000
    }
  },
  mounted() {
    this.initDiceBox();
  },
  methods: {
    async initDiceBox() {
      this.diceBox = new DiceBox("#dice-container", {
        assetPath: '/ui/dist/assets/', //If testing localhost, change this to '/assets/'
        scale: 3.5
      });
      await this.diceBox.init();

      this.diceBox.onRollComplete = (rollResult) => {
        this.rolling = false
        this.$emit('result', { type: 'rollComplete', data: rollResult })

        if (this.autoClear == true) {
          this.autoClearTimout = setTimeout(() => {
            this.clearDice()
          }, this.autoClearTime)
        }
      }
      this.diceBox.onBeforeRoll = (parsedNotation) => {
        this.rolling = true
        this.$emit('result', { type: 'beforeRoll', data: parsedNotation })
      }
      this.diceBox.onDieComplete = (dieResult) => {
        this.$emit('result', { type: 'dieComplete', data: dieResult })
      }
      this.diceBox.onRemoveComplete = (dieResult) => {
        this.$emit('result', { type: 'removeComplete', data: dieResult })
      }
    },
    triggerAction(action, args) {
      if (action == 'roll') this.rollDice(args.notation, args.color ?? '#33ddff', args?.autoClear)
      else if (action == 'add') this.addDice(args.notation, args.color ?? '#33ddff')
      else if (action == 'remove') this.removeDice(args.notation)
      else if (action == 'reroll') this.rerollDice(args.notation, args?.autoClear)
      else if (action == 'clear') this.clearDice()
    },
    async rollDice(notation, color, autoClear) {
      if (this.rolling == false) {
        this.autoClear = autoClear?.active ?? true
        this.autoClearTime = autoClear?.time ?? 5000

        if (this.autoClearTimout) clearTimeout(this.autoClearTimout)
        this.diceBox.show()
        this.diceBox.roll(notation, { themeColor: color })
      }
    },
    async addDice(notation, color) {
      this.diceBox.show()
      this.diceBox.add(notation, { themeColor: color })
    },
    async rerollDice(notation, autoClear) {
      if (this.rolling == false) {
        this.autoClear = autoClear?.active ?? true
        this.autoClearTime = autoClear?.time ?? 5000
        if (this.autoClearTimout) clearTimeout(this.autoClearTimout)

        this.diceBox.reroll(notation, {
          remove: true
        })
      }
    },
    async removeDice(notation) {
      this.diceBox.remove(notation)
    },
    async clearDice() {
      this.diceBox.clear()
      this.diceBox.hide()
    },
  },
};
</script>
<style>
#dice-container,
.dice-box-canvas {
  width: 100vw;
  height: 100vh;
}

#dice-box {
  position: relative;
  box-sizing: border-box;
  width: 100%;
  height: 100%;
}

#dice-box canvas {
  width: 100%;
  height: 100%;
}
</style>