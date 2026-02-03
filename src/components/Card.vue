<template>
  <div 
    class="card" 
    :class="{ 
      'card-flipped': isFlipped, 
      'card-interactive': isInteractive,
      'card-hovered': isHovered
    }"
    :style="cardStyle"
    @click="handleClick"
    @mouseenter="handleMouseEnter"
    @mouseleave="handleMouseLeave"
    @touchstart="handleTouchStart"
    @touchend="handleTouchEnd"
  >
    <div class="card-inner">
      <div class="card-face card-back">
        <div class="back-pattern"></div>
      </div>
      <div class="card-face card-front" :style="frontStyle">
        <div class="rank">{{ card.rank }}</div>
        <div class="suit-center">{{ suitName }}</div>
        <div class="divination-panel">
          <p class="divination-text">{{ card.divination }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import type { SoulCard } from '../data/cards';

interface Props {
  card: SoulCard;
  isFlipped?: boolean;
  showBack?: boolean;
  isInteractive?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  isFlipped: false,
  showBack: false,
  isInteractive: true
});

const emit = defineEmits<{
  click: [card: SoulCard]
  hover: [card: SoulCard | null]
}>();

const isHovered = ref(false);

const suitColors: Record<string, string> = {
  earth: 'var(--suit-earth)',
  water: 'var(--suit-water)',
  fire: 'var(--suit-fire)',
  air: 'var(--suit-air)',
  space: 'var(--suit-space)',
  time: 'var(--suit-time)'
};

const textColors: Record<string, string> = {
  earth: 'var(--text-on-earth)',
  water: 'var(--text-on-water)',
  fire: 'var(--text-on-fire)',
  air: 'var(--text-on-air)',
  space: 'var(--text-on-space)',
  time: 'var(--text-on-time)'
};

const suitNames: Record<string, string> = {
  earth: 'EARTH',
  water: 'WATER',
  fire: 'FIRE',
  air: 'AIR',
  space: 'SPACE',
  time: 'TIME'
};

const suitName = computed(() => suitNames[props.card.suit]);

const frontStyle = computed(() => ({
  backgroundColor: suitColors[props.card.suit],
  color: textColors[props.card.suit]
}));

const cardStyle = computed(() => ({
  '--suit-color': suitColors[props.card.suit],
  '--text-color': textColors[props.card.suit]
}));

const handleClick = () => {
  emit('click', props.card);
};

const handleMouseEnter = () => {
  if (props.isInteractive) {
    isHovered.value = true;
    emit('hover', props.card);
  }
};

const handleMouseLeave = () => {
  if (props.isInteractive) {
    isHovered.value = false;
    emit('hover', null);
  }
};

const handleTouchStart = () => {
  if (props.isInteractive) {
    isHovered.value = true;
    emit('hover', props.card);
  }
};

const handleTouchEnd = () => {
  if (props.isInteractive) {
    setTimeout(() => {
      isHovered.value = false;
      emit('hover', null);
    }, 100);
  }
};
</script>

<style scoped>
.card {
  width: 200px;
  height: 300px;
  perspective: 1000px;
  cursor: pointer;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), 
              filter 0.3s ease,
              z-index 0s;
  will-change: transform;
}

.card-interactive:hover,
.card-interactive:active {
  transform: translateY(-20px) scale(1.15) !important;
  filter: brightness(1.2);
  z-index: 1000 !important;
}

.card-interactive.card-hovered {
  transform: translateY(-20px) scale(1.15) !important;
  filter: brightness(1.2);
  z-index: 1000 !important;
}

.card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
  transition: transform 0.6s;
}

.card-flipped .card-inner {
  transform: rotateY(180deg);
}

.card-face {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  border-radius: 12px;
  border: 2px solid rgba(255, 255, 255, 0.1);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
  overflow: hidden;
  transition: box-shadow 0.3s ease, border-color 0.3s ease;
}

.card-interactive:hover .card-face,
.card-interactive:active .card-face,
.card-interactive.card-hovered .card-face {
  box-shadow: 0 12px 32px rgba(126, 200, 227, 0.4),
              0 4px 16px rgba(0, 0, 0, 0.5);
  border-color: rgba(126, 200, 227, 0.5);
}

.card-back {
  background: linear-gradient(135deg, #1A1A2E 0%, #2A2A3E 100%);
  transform: rotateY(0deg);
}

.back-pattern {
  width: 100%;
  height: 100%;
  background-image: 
    repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(255, 255, 255, 0.03) 10px, rgba(255, 255, 255, 0.03) 20px);
  position: relative;
}

.back-pattern::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 80px;
  height: 80px;
  border: 3px solid rgba(255, 255, 255, 0.1);
  border-radius: 50%;
}

.card-front {
  transform: rotateY(180deg);
  display: flex;
  flex-direction: column;
  padding: 1rem;
}

.rank {
  font-size: 1.8rem;
  font-weight: 600;
  position: absolute;
  top: 0.8rem;
  left: 1rem;
}

.suit-center {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2.5rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-align: center;
}

.divination-panel {
  background-color: rgba(0, 0, 0, 0.3);
  padding: 1rem;
  border-radius: 8px;
  margin-top: auto;
}

.divination-text {
  font-size: 0.9rem;
  line-height: 1.4;
  text-align: center;
  font-weight: 400;
}

@media (max-width: 430px) {
  .card {
    width: 160px;
    height: 240px;
  }

  .card-interactive:hover,
  .card-interactive:active,
  .card-interactive.card-hovered {
    transform: translateY(-15px) scale(1.12) !important;
  }

  .rank {
    font-size: 1.4rem;
    top: 0.6rem;
    left: 0.8rem;
  }

  .suit-center {
    font-size: 2rem;
  }

  .divination-text {
    font-size: 0.75rem;
  }
}
</style>
