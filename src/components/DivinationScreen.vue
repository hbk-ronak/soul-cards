<template>
  <div class="divination-screen">
    <div v-if="state === 'IDLE'" class="idle-state">
      <button class="shuffle-button" @click="handleShuffle">Shuffle</button>
    </div>
    
    <CardFan
      v-if="state === 'FANNED'"
      :cards="shuffledCards"
      :is-visible="fanVisible"
      @card-selected="handleCardSelected"
    />
    
    <CardReveal
      v-if="state === 'REVEALING'"
      :card="selectedCard!"
      @shuffle-again="handleShuffleAgain"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, nextTick } from 'vue';
import CardFan from './CardFan.vue';
import CardReveal from './CardReveal.vue';
import { allCards, type SoulCard } from '../data/cards';

type DivinationState = 'IDLE' | 'FANNED' | 'REVEALING';

const state = ref<DivinationState>('IDLE');
const shuffledCards = ref<SoulCard[]>([]);
const selectedCard = ref<SoulCard | null>(null);
const fanVisible = ref(false);

const shuffleArray = <T>(array: T[]): T[] => {
  const shuffled = [...array];
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
  }
  return shuffled;
};

const handleShuffle = async () => {
  shuffledCards.value = shuffleArray(allCards);
  state.value = 'FANNED';
  fanVisible.value = false;
  await nextTick();
  setTimeout(() => {
    fanVisible.value = true;
  }, 50);
};

const handleCardSelected = (card: SoulCard) => {
  selectedCard.value = card;
  state.value = 'REVEALING';
};

const handleShuffleAgain = () => {
  state.value = 'IDLE';
  selectedCard.value = null;
  shuffledCards.value = [];
  fanVisible.value = false;
};
</script>

<style scoped>
.divination-screen {
  min-height: 100vh;
  width: 100%;
  position: relative;
}

.idle-state {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.shuffle-button {
  padding: 1.2rem 3rem;
  font-size: 1.3rem;
  font-family: 'Cinzel', serif;
  background-color: #2A2A3E;
  color: #F0F0F0;
  border: 2px solid #7EC8E3;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 600;
}

.shuffle-button:hover {
  background-color: #3A3A4E;
  border-color: #9ED8F3;
  transform: scale(1.05);
}

.shuffle-button:active {
  transform: scale(0.98);
}
</style>
