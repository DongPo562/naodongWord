<template>
  <!-- 恭喜完成模态窗口 -->
  <div v-if="visible" class="modal-overlay" @click="handleClose">
    <div class="congratulation-modal" @click.stop>
      <div class="congratulation-header">
        <h2>🎉 恭喜完成！</h2>
      </div>
      <div class="congratulation-body">
        <p>您已经完成了 {{ versionText }} 的所有单词学习！</p>
        <p>共学习了 {{ wordCount }} 个单词</p>
      </div>
      <div class="congratulation-footer">
        <button class="congratulation-btn" @click="handleClose">继续学习</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// 定义组件的 props
interface Props {
  visible: boolean
  versionText: string
  wordCount: number
}

// 定义组件的 emits
interface Emits {
  close: []
}

defineProps<Props>()
const emit = defineEmits<Emits>()

// 处理关闭事件
const handleClose = () => {
  emit('close')
}
</script>

<style scoped>
/* 恭喜模态窗口样式 */
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

.congratulation-modal {
  width: 400px;
  background-color: #FFFFFF;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  animation: modalSlideIn 0.3s ease-out;
}

@keyframes modalSlideIn {
  from {
    transform: translateY(-50px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

.congratulation-header {
  padding: 30px;
  text-align: center;
  background: linear-gradient(135deg, #F3843F, #FF9A56);
  color: white;
}

.congratulation-header h2 {
  font-family: Inter;
  font-size: 24px;
  font-weight: 600;
  margin: 0;
}

.congratulation-body {
  padding: 30px;
  text-align: center;
}

.congratulation-body p {
  font-family: Inter;
  font-size: 16px;
  color: #333333;
  margin: 10px 0;
  line-height: 1.5;
}

.congratulation-footer {
  padding: 20px 30px 30px;
  text-align: center;
}

.congratulation-btn {
  padding: 12px 30px;
  background-color: #F3843F;
  color: white;
  border: none;
  border-radius: 25px;
  font-family: Inter;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 8px rgba(243, 132, 63, 0.3);
}

.congratulation-btn:hover {
  background-color: #E6732D;
  transform: translateY(-2px);
  box-shadow: 0 6px 12px rgba(243, 132, 63, 0.4);
}

@media (max-width: 960px) {
  .congratulation-modal {
    width: 90vw;
    max-width: 350px;
  }
}
</style>