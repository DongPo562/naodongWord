<template>
  <div class="modal-overlay" @click="closeModal">
    <div class="modal-content" @click.stop>
      <div class="modal-header">
        <h2>选择单元</h2>
        <button class="close-btn" @click="closeModal">×</button>
      </div>
      
      <div class="modal-body">
        <div class="selection-section">
          <h3>{{ textbookInfo }}</h3>
          <div class="unit-grid">
            <button 
              v-for="unit in availableUnits" 
              :key="unit.key"
              :class="['unit-btn', { active: selectedUnit === unit.number }]"
              @click="selectUnit(unit.number)"
            >
              {{ unit.display }}
            </button>
          </div>
        </div>
      </div>
      
      <div class="modal-footer">
        <button class="cancel-btn" @click="closeModal">取消</button>
        <button 
          class="confirm-btn" 
          :disabled="!selectedUnit"
          @click="confirmSelection"
        >
          确定
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'

interface UnitInfo {
  key: string
  number: string
  display: string
}

const props = defineProps<{
  textbookSelection: { publisher: any, grade: string } | null
  currentUnit: string
}>()

const emit = defineEmits(['close', 'confirm'])

const selectedUnit = ref<string>('')
const availableUnits = ref<UnitInfo[]>([])

// 计算教材信息显示文本
const textbookInfo = computed(() => {
  if (props.textbookSelection) {
    const publisherName = props.textbookSelection.publisher.name
    const grade = props.textbookSelection.grade
    return `${publisherName}${grade}`
  }
  return '人教版三年级下'
})

// 加载可用单元
const loadAvailableUnits = async () => {
  if (!props.textbookSelection) {
    // 默认单元
    availableUnits.value = [
      { key: 'Unit 1', number: '1', display: 'Unit 1' },
      { key: 'Unit 2', number: '2', display: 'Unit 2' },
      { key: 'Unit 3', number: '3', display: 'Unit 3' },
      { key: 'Unit 4', number: '4', display: 'Unit 4' },
      { key: 'Unit 5', number: '5', display: 'Unit 5' },
      { key: 'Unit 6', number: '6', display: 'Unit 6' }
    ]
    return
  }

  try {
    // 加载词汇表数据
    const vocabularyPath = `/src/data/vocabulary/${props.textbookSelection.publisher.id}_${props.textbookSelection.grade}.json`
    const vocabularyResponse = await fetch(vocabularyPath)
    const vocabularyData = await vocabularyResponse.json()
    
    // 获取所有单元
    const units = vocabularyData.units || {}
    availableUnits.value = Object.keys(units).map(unitKey => {
      const unitNumber = unitKey.replace('Unit ', '')
      return {
        key: unitKey,
        number: unitNumber,
        display: unitKey
      }
    })
  } catch (error) {
    console.error('加载单元数据失败:', error)
    // 使用默认单元作为后备
    availableUnits.value = [
      { key: 'Unit 1', number: '1', display: 'Unit 1' },
      { key: 'Unit 2', number: '2', display: 'Unit 2' },
      { key: 'Unit 3', number: '3', display: 'Unit 3' },
      { key: 'Unit 4', number: '4', display: 'Unit 4' },
      { key: 'Unit 5', number: '5', display: 'Unit 5' },
      { key: 'Unit 6', number: '6', display: 'Unit 6' }
    ]
  }
}

// 选择单元
const selectUnit = (unitNumber: string) => {
  selectedUnit.value = unitNumber
}

// 关闭模态窗口
const closeModal = () => {
  emit('close')
}

// 确认选择
const confirmSelection = () => {
  if (selectedUnit.value) {
    emit('confirm', selectedUnit.value)
  }
}

onMounted(() => {
  loadAvailableUnits()
  // 设置当前单元为默认选择
  selectedUnit.value = props.currentUnit || '1'
})
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  width: 50vw;
  height: 60vh;
  background-color: #FFFFFF;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 30px;
  border-bottom: 1px solid #E5E5E5;
  background-color: #FBE5D6;
}

.modal-header h2 {
  font-family: Inter;
  font-size: 24px;
  font-weight: 600;
  color: #333333;
  margin: 0;
}

.close-btn {
  background: none;
  border: none;
  font-size: 30px;
  color: #666666;
  cursor: pointer;
  padding: 0;
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.close-btn:hover {
  background-color: rgba(0, 0, 0, 0.1);
  color: #333333;
}

.modal-body {
  flex: 1;
  padding: 30px;
  overflow-y: auto;
}

.selection-section {
  margin-bottom: 30px;
}

.selection-section h3 {
  font-family: Inter;
  font-size: 18px;
  font-weight: 500;
  color: #333333;
  margin-bottom: 15px;
}

.unit-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 12px;
}

.unit-btn {
  padding: 12px 16px;
  border: 2px solid #E5E5E5;
  border-radius: 8px;
  background-color: #FFFFFF;
  color: #666666;
  font-family: Inter;
  font-size: 14px;
  font-weight: 400;
  cursor: pointer;
  transition: all 0.3s ease;
  text-align: center;
}

.unit-btn:hover {
  border-color: #F3843F;
  color: #F3843F;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(243, 132, 63, 0.2);
}

.unit-btn.active {
  border-color: #F3843F;
  background-color: #F3843F;
  color: #FFFFFF;
  box-shadow: 0 4px 8px rgba(243, 132, 63, 0.3);
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 15px;
  padding: 20px 30px;
  border-top: 1px solid #E5E5E5;
  background-color: #F9F9F9;
}

.cancel-btn,
.confirm-btn {
  padding: 12px 24px;
  border: none;
  border-radius: 8px;
  font-family: Inter;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.cancel-btn {
  background-color: #E5E5E5;
  color: #666666;
}

.cancel-btn:hover {
  background-color: #D0D0D0;
  color: #333333;
}

.confirm-btn {
  background-color: #F3843F;
  color: #FFFFFF;
}

.confirm-btn:hover:not(:disabled) {
  background-color: #E6732D;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(243, 132, 63, 0.3);
}

.confirm-btn:disabled {
  background-color: #CCCCCC;
  color: #999999;
  cursor: not-allowed;
}

@media (max-width: 960px) {
  .modal-content {
    width: 90vw;
    height: 70vh;
  }
  
  .modal-header {
    padding: 15px 20px;
  }
  
  .modal-header h2 {
    font-size: 20px;
  }
  
  .modal-body {
    padding: 20px;
  }
  
  .unit-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .modal-footer {
    padding: 15px 20px;
  }
}
</style>