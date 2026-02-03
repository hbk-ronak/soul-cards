<template>
  <div class="landing-screen">
    <h1 class="title">Soul Cards</h1>
    <p class="subtitle">A spiritual reflection through divination</p>
    <button class="begin-button" @click="handleBegin">Begin</button>
  </div>
</template>

<script setup lang="ts">
const emit = defineEmits<{
  begin: []
}>();

const handleBegin = () => {
  emit('begin');
};
</script>

<style scoped>
.landing-screen {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  text-align: center;
}

.title {
  font-size: 3.5rem;
  font-weight: 600;
  margin-bottom: 1rem;
  color: #F0F0F0;
  letter-spacing: 0.1em;
}

.subtitle {
  font-size: 1.1rem;
  margin-bottom: 3rem;
  color: #A0A0A0;
  font-weight: 400;
}

.begin-button {
  padding: 1rem 3rem;
  font-size: 1.2rem;
  font-family: 'Cinzel', serif;
  background-color: #2A2A3E;
  color: #F0F0F0;
  border: 2px solid #7EC8E3;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 600;
}

.begin-button:hover {
  background-color: #3A3A4E;
  border-color: #9ED8F3;
  transform: scale(1.05);
}

.begin-button:active {
  transform: scale(0.98);
}
</style>
