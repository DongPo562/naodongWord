<template>
  <div class="operationButtonContainer mobile-only">
    <button class="btn-textbook" @click="showTextBookPage">教材</button>
    <button class="btn-read">阅读</button>
    <button class="btn-record">记录</button>
    <button class="btn-next">next</button>
  </div>
  <div class="mainContainer">
    <div class="leftContainer">
      <div class="operationButtonContainer desktop-only">
        <button class="btn-textbook" @click="showTextBookPage">教材</button>
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
  
  <!-- 教材选择模态窗口 -->
  <TextbookChoosePage 
    v-if="isTextbookModalVisible" 
    @close="closeTextbookModal" 
    @confirm="handleTextbookConfirm"
  />
</template>

<script setup lang="ts">
import { ref } from 'vue'
import TextbookChoosePage from './components/TextbookChoosePage.vue'

// 响应式数据
const isTextbookModalVisible = ref(false)

// 显示教材选择页面
const showTextBookPage = () => {
  isTextbookModalVisible.value = true
}

// 关闭教材选择模态窗口
const closeTextbookModal = () => {
  isTextbookModalVisible.value = false
}

// 处理教材选择确认
const handleTextbookConfirm = (selection: { publisher: any, grade: string }) => {
  console.log('选择的教材:', selection)
  // 这里可以更新版本显示文本
  // 暂时只是关闭模态窗口
  isTextbookModalVisible.value = false
}
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

.operationButtonContainer.mobile-only {
  display: none;
}

.operationButtonContainer.desktop-only {
  width: 18vh;
  height: 100%;
  padding-top: 3vh;
}

.operationButtonContainer button {
  width: 14vh;
  height: 14vh;
  margin: 2vh 1vh 1.5vh 2vh;
  background-color: #F3843F;
  border: none;
  border-radius: 1.5vh 4.5vh 1.5vh 4.5vh;
  box-shadow: 4px 2px 2px 0px rgba(0, 0, 0, 0.25);
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
  border: 1px solid #080808;
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

@media (max-width: 960px) {
  body {
    display: flex;
    flex-direction: column;
  }
  
  .operationButtonContainer.desktop-only {
    display: none;
  }
  
  .operationButtonContainer.mobile-only {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: auto;
    padding: 20px;
    gap: 20px;
    background-color: #FFFFFF;
    order: -1;
  }
  
  .operationButtonContainer.mobile-only button {
    width: 80px;
    height: 80px;
    margin: 0;
    font-size: 16px;
  }
  
  .operationButtonContainer.mobile-only .btn-next {
    margin-top: 0 !important;
  }
  
  .mainContainer {
    height: calc(100vh - 120px);
  }
}
</style>