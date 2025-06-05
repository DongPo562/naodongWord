<template>
  <div class="modal-overlay" @click="closeModal">
    <div class="modal-content" @click.stop>
      <div class="modal-header">
        <h2>选择教材</h2>
        <button class="close-btn" @click="closeModal">×</button>
      </div>
      
      <div class="modal-body">
        <div class="selection-section">
          <h3>出版社</h3>
          <div class="publisher-grid">
            <button 
              v-for="publisher in publishers" 
              :key="publisher.id"
              :class="['publisher-btn', { active: selectedPublisher?.id === publisher.id }]"
              @click="selectPublisher(publisher)"
            >
              {{ publisher.name }}
            </button>
          </div>
        </div>
        
        <div class="selection-section" v-if="selectedPublisher">
          <h3>年级</h3>
          <div class="grade-grid">
            <button 
              v-for="grade in availableGrades" 
              :key="grade"
              :class="['grade-btn', { active: selectedGrade === grade }]"
              @click="selectGrade(grade)"
            >
              {{ grade }}
            </button>
          </div>
        </div>
      </div>
      
      <div class="modal-footer">
        <button class="cancel-btn" @click="closeModal">取消</button>
        <button 
          class="confirm-btn" 
          :disabled="!selectedPublisher || !selectedGrade"
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

interface Publisher {
  id: string
  name: string
  hasGrade2: boolean
}

const emit = defineEmits(['close', 'confirm'])

// 出版社列表
const publishers = ref<Publisher[]>([
  { id: 'bsd', name: '北师大版', hasGrade2: false },
  { id: 'cqu', name: '重庆大学版', hasGrade2: false },
  { id: 'fj', name: '闽教版', hasGrade2: false },
  { id: 'gd', name: '粤教粤人版', hasGrade2: false },
  { id: 'hebei', name: '冀教版（一年级起点）', hasGrade2: true },
  { id: 'hunan', name: '湘少版', hasGrade2: false },
  { id: 'eec', name: '教科版 (EEC学院)', hasGrade2: false },
  { id: 'kj', name: '教科版 (主编：龚亚夫&鲁宗干)', hasGrade2: false },
  { id: 'jieli', name: '接力版', hasGrade2: false },
  { id: 'kepu', name: '科普版', hasGrade2: false },
  { id: 'liaoning', name: '辽宁师大版', hasGrade2: false },
  { id: 'tsinghua', name: '清华大学版', hasGrade2: true },
  { id: 'pep', name: '人教版（PEP) (主编：吴欣)', hasGrade2: false }
])

// 所有年级选项
const allGrades = [
  '二年级上', '二年级下',
  '三年级上', '三年级下',
  '四年级上', '四年级下',
  '五年级上', '五年级下',
]

const selectedPublisher = ref<Publisher | null>(null)
const selectedGrade = ref<string>('')

// 根据选择的出版社计算可用年级
const availableGrades = computed(() => {
  if (!selectedPublisher.value) return []
  
  if (selectedPublisher.value.hasGrade2) {
    return allGrades
  } else {
    return allGrades.filter(grade => !grade.includes('二年级'))
  }
})

// 选择出版社
const selectPublisher = (publisher: Publisher) => {
  selectedPublisher.value = publisher
  selectedGrade.value = '' // 重置年级选择
  
  // 缓存选择
  localStorage.setItem('selectedPublisher', JSON.stringify(publisher))
}

// 选择年级
const selectGrade = (grade: string) => {
  selectedGrade.value = grade
  
  // 缓存选择
  localStorage.setItem('selectedGrade', grade)
}

// 关闭模态窗口
const closeModal = () => {
  emit('close')
}

// 确认选择
const confirmSelection = () => {
  if (selectedPublisher.value && selectedGrade.value) {
    emit('confirm', {
      publisher: selectedPublisher.value,
      grade: selectedGrade.value
    })
  }
}

// 从缓存加载之前的选择
const loadCachedSelections = () => {
  const cachedPublisher = localStorage.getItem('selectedPublisher')
  const cachedGrade = localStorage.getItem('selectedGrade')
  
  if (cachedPublisher) {
    try {
      selectedPublisher.value = JSON.parse(cachedPublisher)
    } catch (e) {
      console.error('Failed to parse cached publisher:', e)
    }
  }
  
  if (cachedGrade) {
    selectedGrade.value = cachedGrade
  }
}

onMounted(() => {
  loadCachedSelections()
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
  width: 60vw;
  height: 80vh;
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

.publisher-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 12px;
}

.grade-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 12px;
}

.publisher-btn,
.grade-btn {
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

.publisher-btn:hover,
.grade-btn:hover {
  border-color: #F3843F;
  color: #F3843F;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(243, 132, 63, 0.2);
}

.publisher-btn.active,
.grade-btn.active {
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
    height: 85vh;
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
  
  .publisher-grid {
    grid-template-columns: 1fr;
  }
  
  .grade-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .modal-footer {
    padding: 15px 20px;
  }
}
</style>