<template>
  <div class="card-fan">
    <Card
      v-for="(card, index) in cards"
      :key="card.id"
      :card="card"
      :is-interactive="isVisible"
      :style="getCardStyle(index, card.id)"
      @click="handleCardClick"
      @hover="handleCardHover"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import Card from './Card.vue';
import type { SoulCard } from '../data/cards';

interface Props {
  cards: SoulCard[];
  isVisible: boolean;
}

const props = defineProps<Props>();

const emit = defineEmits<{
  cardSelected: [card: SoulCard]
}>();

const hoveredCardId = ref<string | null>(null);
const viewportWidth = ref(typeof window !== 'undefined' ? window.innerWidth : 430);

const isMobile = computed(() => viewportWidth.value <= 430);

const updateViewportWidth = () => {
  viewportWidth.value = window.innerWidth;
};

onMounted(() => {
  if (typeof window !== 'undefined') {
    window.addEventListener('resize', updateViewportWidth);
    updateViewportWidth();
  }
});

onUnmounted(() => {
  if (typeof window !== 'undefined') {
    window.removeEventListener('resize', updateViewportWidth);
  }
});

const getCardStyle = (index: number, cardId: string) => {
  const totalCards = props.cards.length;
  const width = viewportWidth.value;
  
  // Responsive calculations
  const cardWidth = isMobile.value ? 160 : 200;
  const totalArcAngle = isMobile.value ? 85 : 130;
  
  // Calculate safe radius to prevent overflow
  // For mobile: ensure cards don't exceed viewport width
  // Account for card width (half width from center) and padding
  const padding = isMobile.value ? 10 : 40;
  const cardHalfWidth = cardWidth / 2;
  const maxHorizontalReach = (width - padding) / 2 - cardHalfWidth;
  
  // Calculate radius based on arc angle and max horizontal reach
  // x = sin(angle) * radius, so radius = x / sin(angle)
  const maxAngleRad = (totalArcAngle * Math.PI) / 360; // half angle in radians
  const safeRadius = isMobile.value
    ? Math.min(maxHorizontalReach / Math.sin(maxAngleRad), 140)
    : 280;
  
  const startAngle = -totalArcAngle / 2;
  const angleStep = totalCards > 1 ? totalArcAngle / (totalCards - 1) : 0;
  const angle = startAngle + index * angleStep;
  const radius = safeRadius;
  const radians = (angle * Math.PI) / 180;
  const x = Math.sin(radians) * radius;
  const y = -Math.cos(radians) * radius;
  const delay = index * 50;
  const isHovered = hoveredCardId.value === cardId;

  if (!props.isVisible) {
    return {
      transform: 'translate(0, 0) rotate(0deg)',
      transformOrigin: 'center bottom',
      transition: `transform 0.6s ease-out ${delay}ms`,
      zIndex: totalCards - index
    };
  }

  return {
    transform: `translate(${x}px, ${y}px) rotate(${angle}deg)`,
    transformOrigin: 'center bottom',
    transition: `transform 0.6s ease-out ${delay}ms`,
    zIndex: isHovered ? 1000 : totalCards - index
  };
};

const handleCardClick = (card: SoulCard) => {
  emit('cardSelected', card);
};

const handleCardHover = (card: SoulCard | null) => {
  hoveredCardId.value = card ? card.id : null;
};
</script>

<style scoped>
.card-fan {
  position: relative;
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: flex-end;
  justify-content: center;
  perspective: 1000px;
  overflow: hidden;
  padding-bottom: 2rem;
}

.card-fan > * {
  position: absolute;
  bottom: 0;
  left: 50%;
  margin-left: -100px;
  transition: transform 0.6s ease-out;
}

@media (max-width: 430px) {
  .card-fan {
    height: 100vh;
    padding-bottom: 1rem;
    overflow: visible;
  }
  
  .card-fan > * {
    margin-left: -80px;
  }
}
</style>
