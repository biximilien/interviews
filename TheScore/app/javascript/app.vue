<template>
  <div id="app">
    <Players></Players>
  </div>
</template>

<script>
import Players from './components/players'

export default {
  components: {
    Players
  },

  data: function () {
    return {
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
