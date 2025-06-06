<template>
  <div class="mainTopMenuPanel mobile-only">
    <div class="menuButtonContainer">
      <button class="btn-textbook" @click="showTextBookPage">教材</button>
      <button class="btn-read">阅读</button>
      <button class="btn-record">记录</button>
    </div>
    <div class="nextBackButtonContainer">
      <button class="btn-back" @click="prevWord">back</button>
      <button class="btn-next" @click="nextWord">next</button>
    </div>
  </div>
  <div class="mainContainer">
    <div class="leftContainer">
      <div class="mainLeftMenuPanel desktop-only">
        <div class="menuButtonContainer">
          <button class="btn-textbook" @click="showTextBookPage">教材</button>
          <button class="btn-read">阅读</button>
          <button class="btn-record">记录</button>
        </div>
        <div class="nextBackButtonContainer">
          <button class="btn-back" @click="prevWord">back</button>
          <button class="btn-next" @click="nextWord">next</button>
        </div>
      </div>
      <div class="memoryContainer">
        <div class="versionContainer">
          <span class="version-text">{{ versionText }}</span>
        </div>
        <div class="wordContainer">
          <span class="word-text">{{ currentWord?.word || 'eraser' }}</span>
        </div>
        <div class="progress-container">
          <div class="progress-bar">
            <div class="progress-fill" :style="{ width: progressPercentage + '%' }"></div>
          </div>
          <span class="progress-text">{{ learnedCount }}/{{ totalCount }}</span>
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
  
  <!-- 恭喜完成模态窗口 -->
  <CompleteUnitLearn 
    :visible="isCongratulationModalVisible"
    :version-text="versionText"
    :word-count="currentUnitContent.length"
    @close="closeCongratulationModal"
  />
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import TextbookChoosePage from './components/TextbookChoosePage.vue'
import CompleteUnitLearn from './components/CompleteUnitLearn.vue'

// 定义单词类型
interface Word {
  wordID: string
  word: string
  phoneticUK: string
  phoneticUS: string
  definition: string
}

// 响应式数据
const isTextbookModalVisible = ref(false)
const isCongratulationModalVisible = ref(false)
const currentUnitContent = ref<Word[]>([])
const currentWordIndex = ref(0)
const selectedTextbook = ref<{ publisher: any, grade: string } | null>(null)

// 计算当前单词
const currentWord = computed(() => {
  if (currentUnitContent.value.length > 0 && currentWordIndex.value < currentUnitContent.value.length) {
    return currentUnitContent.value[currentWordIndex.value]
  }
  return null
})

// 计算版本显示文本
const versionText = computed(() => {
  if (selectedTextbook.value) {
    const publisherName = selectedTextbook.value.publisher.name
    const grade = selectedTextbook.value.grade
    return `${publisherName}${grade} Unit1`
  }
  return '人教版三年级下 Unit5'
})

// 计算学习进度
const totalCount = computed(() => currentUnitContent.value.length)
const learnedCount = computed(() => currentWordIndex.value + 1)
const progressPercentage = computed(() => {
  if (totalCount.value === 0) return 0
  return Math.round((learnedCount.value / totalCount.value) * 100)
})

// 加载单词数据
const loadWordsData = async () => {
  try {
    // 加载基础单词数据
    const wordsResponse = await fetch('/src/data/words/words1-100.json')
    const wordsData: Word[] = await wordsResponse.json()
    
    if (selectedTextbook.value) {
      // 加载词汇表数据
      const vocabularyPath = `/src/data/vocabulary/${selectedTextbook.value.publisher.id}_${selectedTextbook.value.grade}.json`
      console.log('词汇表路径:', vocabularyPath)
      const vocabularyResponse = await fetch(vocabularyPath)
      const vocabularyData = await vocabularyResponse.json()
      
      // 获取Unit 1的单词ID列表
      const unit1WordIds = vocabularyData.units['Unit 1'] || []
      
      // 根据ID查找对应的单词
      currentUnitContent.value = unit1WordIds.map((id: string) => {
        return wordsData.find(word => word.wordID === id)
      }).filter(Boolean)
      
      currentWordIndex.value = 0
    }
  } catch (error) {
    console.error('加载单词数据失败:', error)
  }
}

// 显示教材选择页面
const showTextBookPage = () => {
  isTextbookModalVisible.value = true
}

// 关闭教材选择模态窗口
const closeTextbookModal = () => {
  isTextbookModalVisible.value = false
}

// 处理教材选择确认
const handleTextbookConfirm = async (selection: { publisher: any, grade: string }) => {
  console.log('选择的教材:', selection)
  selectedTextbook.value = selection
  isTextbookModalVisible.value = false
  await loadWordsData()
}

// 上一个单词
const prevWord = () => {
  if (currentUnitContent.value.length === 0) {
    return
  }
  
  if (currentWordIndex.value === 0) {
    alert('这是本单元第一个单词')
    return
  }
  
  currentWordIndex.value--
}

// 下一个单词
const nextWord = () => {
  if (currentUnitContent.value.length === 0) {
    return
  }
  
  if (currentWordIndex.value < currentUnitContent.value.length - 1) {
    currentWordIndex.value++
  } else {
    // 显示恭喜模态窗口
    isCongratulationModalVisible.value = true
  }
}

// 关闭恭喜模态窗口
const closeCongratulationModal = () => {
  isCongratulationModalVisible.value = false
}
</script>

<style>
/* 全局样式重置 */
html, body {
  margin: 0;
  padding: 0;
  overflow: hidden;
  height: 100%;
  width: 100%;
}
</style>

<style scoped>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

.mainContainer {
  width: 100%;
  height: 100vh;
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

.mainTopMenuPanel.mobile-only {
  display: none;
}

.mainLeftMenuPanel.desktop-only {
  width: 18vh;
  height: 100%;
  padding-top: 3vh;
}

/* 菜单按钮样式 (教材、阅读、记录) */
.btn-textbook,
.btn-read,
.btn-record {
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

.btn-textbook:hover,
.btn-read:hover,
.btn-record:hover {
  transform: translateY(-2px);
  box-shadow: 7px 6px 6px 0px rgba(0, 0, 0, 0.3);
}

.nextBackButtonContainer {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-top: 8vh;
}


/* 导航按钮样式 (back、next) */
.btn-back,
.btn-next {
  width: 14vh;
  height: 14vh;
  margin: 2vh 1vh 1.5vh 2vh;
  background-color: #F3843F;
  border: none;
  border-radius: 50%;
  box-shadow: 4px 2px 2px 0px rgba(0, 0, 0, 0.25);
  color: #FFFFFF;
  font-family: Inter;
  font-size: 3.5vh;
  font-weight: 300;
  text-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-back:hover,
.btn-next:hover {
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

.progress-container {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 15px;
  width: 80%;
  height: 60px;
  margin: 20px auto;
}

.progress-bar {
  flex: 1;
  height: 8px;
  background-color: #E0E0E0;
  border-radius: 4px;
  overflow: hidden;
  position: relative;
}

.progress-fill {
  height: 100%;
  background-color: #F3843F;
  border-radius: 4px;
  transition: width 0.3s ease;
}

.progress-text {
  font-family: Inter;
  font-size: 16px;
  font-weight: 500;
  color: #525252;
  min-width: 50px;
  text-align: center;
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
  
  .mainLeftMenuPanel.desktop-only {
    display: none;
  }
  
  .mainTopMenuPanel.mobile-only {
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
  
  .mainTopMenuPanel.mobile-only .menuButtonContainer {
    display: flex;
    gap: 20px;
  }
  
  .mainTopMenuPanel.mobile-only .nextBackButtonContainer {
    display: flex;
    flex-direction: row;
    gap: 20px;
    margin-top: 0!important;
  }
  
  .mainTopMenuPanel.mobile-only button {
    width: 80px;
    height: 80px;
    margin: 0;
    font-size: 16px;
  }
  
  .mainTopMenuPanel.mobile-only .btn-back {
    margin-top: 0 !important;
  }
  
  .mainTopMenuPanel.mobile-only .btn-next {
    margin-top: 0 !important;
  }
  
  .mainContainer {
    height: calc(100vh - 120px);
  }
}
</style>