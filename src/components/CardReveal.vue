<template>
  <div class="card-reveal">
    <div class="reveal-container">
      <Card :card="card" :is-flipped="isFlipped" />
    </div>
    <button v-if="showButton" class="shuffle-again-button" @click="handleShuffleAgain">
      Shuffle Again
    </button>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import Card from './Card.vue';
import type { SoulCard } from '../data/cards';

defineProps<{
  card: SoulCard;
}>();

const emit = defineEmits<{
  shuffleAgain: []
}>();

const isFlipped = ref(false);
const showButton = ref(false);

onMounted(() => {
  setTimeout(() => {
    isFlipped.value = true;
    setTimeout(() => {
      showButton.value = true;
    }, 600);
  }, 100);
});

const handleShuffleAgain = () => {
  emit('shuffleAgain');
};
</script>

<style scoped>
.card-reveal {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  gap: 3rem;
}

.reveal-container {
  perspective: 1000px;
}

.shuffle-again-button {
  padding: 1rem 2.5rem;
  font-size: 1.1rem;
  font-family: 'Cinzel', serif;
  background-color: #2A2A3E;
  color: #F0F0F0;
  border: 2px solid #7EC8E3;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 600;
  opacity: 0;
  animation: fadeIn 0.5s ease forwards;
}

.shuffle-again-button:hover {
  background-color: #3A3A4E;
  border-color: #9ED8F3;
  transform: scale(1.05);
}

.shuffle-again-button:active {
  transform: scale(0.98);
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
