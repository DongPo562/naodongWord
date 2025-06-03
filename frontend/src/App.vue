<template>
  <div class="mainContainer">
    <div class="leftContainer">
      <div class="operationButtonContainer">
        <button class="btn-textbook">教材</button>
        <button class="btn-read">阅读</button>
        <button class="btn-record">记录</button>
        <button class="btn-next">next</button>
      </div>
      <div class="memoryContainer">
        <div class="versionContainer">
          <span class="version-text">人教版三年级下 Unit5</span>
        </div>
        <div class="wordContainer">
          <span class="word-text">eraser</span>
        </div>
        <div class="letterAssociationContainer">
          <!-- 字母联想区域 -->
        </div>
      </div>
    </div>
    <div class="rightContainer">
      <img src="/images/elephant.png" alt="elephant" class="elephant-image" />
    </div>
  </div>
</template>

<script setup lang="ts">
// Vue 3 Composition API
</script>

<style scoped>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  overflow: hidden;
  margin: 0;
  padding: 0;
}

.mainContainer {
  width: 100%;
  height: calc(100vh - 16px);
  display: flex;
  overflow: hidden;
  background-color: #FFFFFF;
  margin: 0;
  padding: 0;
}

.leftContainer {
  flex: 1;
  display: flex;
  background-color: #FBE5D6;
  border-radius: 15px;
  margin: 0 5px 0 0;
  overflow: hidden;
}

.operationButtonContainer {
  width: 18vh;
  height: 100%;
  padding-top:3vh;
}

.operationButtonContainer button {
  width: 14vh;
  height: 14vh;
  margin: 2vh 1vh 1.5vh 2vh;
  background-color: #F3843F;
  border: none;
  border-radius: 1.5vh 4.5vh 1.5vh 4.5vh;
  box-shadow: 5px 3px 3px 0px rgba(0, 0, 0, 0.25);
  color: #FFFFFF;
  font-family: Inter;
  font-size: 3.5vh;
  font-weight: 300;
  text-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-next {
  border-radius: 50% !important;
  margin-top: 15vh !important;
}

.operationButtonContainer button:hover {
  transform: translateY(-2px);
  box-shadow: 7px 6px 6px 0px rgba(0, 0, 0, 0.3);
}

.memoryContainer {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 0 10px 0 0;
}

.versionContainer {
  display: flex;
  justify-content: right;
  align-items: center;
  height: 40px;
  margin: 0;
  padding: 0;
}

.version-text {
  font-family: Inter;
  font-size: 16px;
  font-weight: 400;
  color: #525252;
  text-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
  margin-right: 10px;
}

.wordContainer {
  display: flex;
  justify-content: center;
  height: 30vh;

}

.word-text {
  font-family: 'Inknut Antiqua', serif;
  font-size: 10vh;
  font-weight: 400;
  color: #000000;
  letter-spacing: 0.9vw;
  margin-top:4vh;
}

.letterAssociationContainer {
  flex: 1;
  background-color: #E9A6A6;
  border-radius: 10px;
}

.rightContainer {
  width: auto;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  border-radius: 15px;
}

.elephant-image {
  height: 100%;
  width: 100%;
  aspect-ratio: 9/16;
  object-fit: cover;
  object-position: center;
}

@media (max-width: 768px) {
  .mainContainer {
    flex-direction: column;
  }
  
  .leftContainer {
    flex-direction: column;
  }
  
  .operationButtonContainer {
    flex-direction: row;
    padding: 20px;
    gap: 20px;
  }
  
  .operationButtonContainer button {
    width: 120px;
    height: 120px;
    font-size: 24px;
  }
  
  .word-text {
    font-size: 64px;
  }
  
  .rightContainer {
    height: 40vh;
  }
}
</style>