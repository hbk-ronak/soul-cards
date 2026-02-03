<template>
  <LandingScreen v-if="currentScreen === 'landing'" @begin="handleBegin" />
  <DivinationScreen v-else />
</template>

<script setup lang="ts">
import { ref } from 'vue';
import LandingScreen from './components/LandingScreen.vue';
import DivinationScreen from './components/DivinationScreen.vue';

type Screen = 'landing' | 'divination';

const currentScreen = ref<Screen>('landing');

const handleBegin = () => {
  currentScreen.value = 'divination';
};
</script>

<style scoped>
</style>
