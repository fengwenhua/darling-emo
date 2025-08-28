<template>
  <div class="app">
    <div class="container">
      <!-- 标题区域 -->
      <div class="header" v-if="currentStep === 0">
        <h1 class="title">亲爱的老婆仔 💕</h1>
        <p class="subtitle">让我们一起走出emo困境吧</p>
        <div class="start-btn" @click="startQuiz">
          开始吧 ✨
        </div>
      </div>

      <!-- 问题区域 -->
      <div class="question-container" v-else-if="currentStep <= questions.length">
        <div class="question-card">
          <div class="question-number">第 {{ currentStep }} 题</div>
          <h2 class="question-text">{{ currentQuestion.question }}</h2>
          
          <div class="options">
            <button 
              v-for="(option, index) in currentQuestion.options" 
              :key="index"
              class="option-btn"
              :class="{ 'selected': selectedOption === index }"
              @click="selectOption(index)"
            >
              {{ option.text }}
            </button>
          </div>

          <div class="navigation">
            <button 
              v-if="currentStep > 1" 
              class="nav-btn prev-btn"
              @click="prevQuestion"
            >
              ← 上一题
            </button>
            <button 
              v-if="selectedOption !== null" 
              class="nav-btn next-btn"
              @click="nextQuestion"
            >
              {{ currentStep === questions.length ? '查看结果' : '下一题' }} →
            </button>
          </div>
        </div>
      </div>

      <!-- 温馨动画区域 -->
      <div class="happy-container" v-else-if="currentStep === 'happy'">
        <div class="happy-card">
          <div class="celebration">
            <div class="sparkles">
              <span class="sparkle">✨</span>
              <span class="sparkle">✨</span>
              <span class="sparkle">✨</span>
              <span class="sparkle">✨</span>
              <span class="sparkle">✨</span>
              <span class="sparkle">✨</span>
            </div>
            <h2 class="happy-title">🎉 太棒啦！</h2>
            <p class="happy-text">老婆仔心情不错呢～</p>
            <div class="happy-emoji">😊</div>
            <p class="happy-message">继续保持这份好心情吧！</p>
            <p class="happy-message">记住，你值得拥有快乐和幸福～</p>
          </div>
          
          <div class="action-buttons">
            <button class="action-btn primary" @click="restartQuiz">
              重新开始 🔄
            </button>
            <button class="action-btn secondary" @click="goHome">
              回到首页 🏠
            </button>
          </div>
        </div>
      </div>

      <!-- 结果区域 -->
      <div class="result-container" v-else>
        <div class="result-card">
          <h2 class="result-title">💡 理智分析结果</h2>
          <div class="result-content">
            <p class="result-text">{{ getResultText() }}</p>
          </div>
          
          <div class="action-buttons">
            <button class="action-btn primary" @click="restartQuiz">
              重新开始 🔄
            </button>
            <button class="action-btn secondary" @click="goHome">
              回到首页 🏠
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'App',
  data() {
    return {
      currentStep: 0,
      selectedOption: null,
      answers: [],
      questions: [
        {
          question: "是不是最近emo啦？😔",
          options: [
            { text: "是 😢", value: "yes" },
            { text: "否 😊", value: "no" }
          ]
        },
        {
          question: "主要是什么原因让你emo呢？",
          options: [
            { text: "工作压力大 💼", value: "work" },
            { text: "学习压力大 📚", value: "study" },
            { text: "生活压力大 🏠", value: "life" },
            { text: "其他原因 🤔", value: "other" }
          ]
        },
        {
          question: "关于工作，你最希望发生什么改变？",
          options: [
            { text: "涨工资 💰", value: "salary" },
            { text: "减少工作量 ⏰", value: "workload" },
            { text: "改善工作环境 🌟", value: "environment" },
            { text: "其他 🎯", value: "other" }
          ]
        },
        {
          question: "面对不涨薪但工作量增加的情况，你会选择？",
          options: [
            { text: "默默接受，自愿加班 😔", value: "accept" },
            { text: "接受现实，但绝不加班 ⚡", value: "no-overtime" },
            { text: "委婉沟通，寻求理解 🤝", value: "communicate" },
            { text: "硬气谈判，不涨薪就不干 💪", value: "negotiate" }
          ]
        }
      ]
    }
  },
  computed: {
    currentQuestion() {
      return this.questions[this.currentStep - 1]
    }
  },
  methods: {
    startQuiz() {
      this.currentStep = 1
      this.answers = []
      this.selectedOption = null
    },
    
    selectOption(index) {
      this.selectedOption = index
      // 自动进入下一题
      this.$nextTick(() => {
        this.nextQuestion()
      })
    },
    
    nextQuestion() {
      if (this.selectedOption !== null) {
        this.answers.push({
          question: this.currentQuestion.question,
          answer: this.currentQuestion.options[this.selectedOption]
        })
        
        // 如果第一题选择"否"，直接显示温馨动画
        if (this.currentStep === 1 && this.currentQuestion.options[this.selectedOption].value === "no") {
          this.currentStep = "happy"
          return
        }
        
        if (this.currentStep < this.questions.length) {
          this.currentStep++
          this.selectedOption = null
        } else {
          this.currentStep++
        }
      }
    },
    
    prevQuestion() {
      if (this.currentStep > 1) {
        this.currentStep--
        this.answers.pop()
        this.selectedOption = null
      }
    },
    
    getResultText() {
      const lastAnswer = this.answers[this.answers.length - 1]
      
      if (lastAnswer && lastAnswer.answer.value === "accept") {
        return "选择默默接受加班，虽然体现了你的责任心，但这样下去你会越来越累。记住，你的时间和精力也是宝贵的！"
      } else if (lastAnswer && lastAnswer.answer.value === "no-overtime") {
        return "选择不加班是对的！工作只是生活的一部分，你有权利享受属于自己的时间。"
      } else if (lastAnswer && lastAnswer.answer.value === "communicate") {
        return "选择沟通是明智的！委婉地表达你的想法，让领导了解你的处境，这是解决问题的好方法。"
      } else if (lastAnswer && lastAnswer.answer.value === "negotiate") {
        return "选择硬气谈判很有勇气！记住，你有选择的权利，不要害怕为自己争取应得的权益。"
      }
      
      return "亲爱的老婆仔，无论你选择什么，都要记住：你值得被尊重，你的付出应该得到回报。不要害怕改变，勇敢地为自己争取更好的生活！💪💕"
    },
    
    restartQuiz() {
      this.currentStep = 1
      this.answers = []
      this.selectedOption = null
    },
    
    goHome() {
      this.currentStep = 0
      this.answers = []
      this.selectedOption = null
    }
  }
}
</script>

<style scoped>
.app {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.container {
  width: 100%;
  max-width: 600px;
  text-align: center;
}

/* 标题区域样式 */
.header {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 40px 30px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
}

.title {
  font-size: 2.5rem;
  color: #4a5568;
  margin-bottom: 15px;
  font-weight: 700;
}

.subtitle {
  font-size: 1.2rem;
  color: #718096;
  margin-bottom: 30px;
}

.start-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 15px 40px;
  border-radius: 50px;
  font-size: 1.2rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  display: inline-block;
}

.start-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
}

/* 问题区域样式 */
.question-container {
  width: 100%;
}

.question-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 40px 30px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
}

.question-number {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 8px 20px;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
  display: inline-block;
  margin-bottom: 20px;
}

.question-text {
  font-size: 1.5rem;
  color: #2d3748;
  margin-bottom: 30px;
  line-height: 1.4;
}

.options {
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin-bottom: 30px;
}

.option-btn {
  background: #f7fafc;
  border: 2px solid #e2e8f0;
  padding: 20px;
  border-radius: 15px;
  font-size: 1.1rem;
  color: #4a5568;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 500;
}

.option-btn:hover {
  border-color: #667eea;
  background: #edf2f7;
  transform: translateY(-2px);
}

.option-btn.selected {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-color: #667eea;
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
}

.navigation {
  display: flex;
  justify-content: space-between;
  gap: 15px;
}

.nav-btn {
  padding: 12px 25px;
  border: none;
  border-radius: 25px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.prev-btn {
  background: #e2e8f0;
  color: #4a5568;
}

.prev-btn:hover {
  background: #cbd5e0;
}

.next-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.next-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 16px rgba(102, 126, 234, 0.4);
}

/* 温馨动画区域样式 */
.happy-container {
  width: 100%;
}

.happy-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 40px 30px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  text-align: center;
}

.celebration {
  position: relative;
  margin-bottom: 30px;
}

.sparkles {
  position: absolute;
  top: -20px;
  left: 0;
  right: 0;
  height: 100px;
}

.sparkle {
  position: absolute;
  font-size: 2rem;
  animation: sparkle 2s infinite;
}

.sparkle:nth-child(1) { left: 10%; animation-delay: 0s; }
.sparkle:nth-child(2) { left: 20%; animation-delay: 0.3s; }
.sparkle:nth-child(3) { left: 30%; animation-delay: 0.6s; }
.sparkle:nth-child(4) { left: 70%; animation-delay: 0.9s; }
.sparkle:nth-child(5) { left: 80%; animation-delay: 1.2s; }
.sparkle:nth-child(6) { left: 90%; animation-delay: 1.5s; }

@keyframes sparkle {
  0%, 100% { 
    opacity: 0; 
    transform: scale(0.5) rotate(0deg); 
  }
  50% { 
    opacity: 1; 
    transform: scale(1.2) rotate(180deg); 
  }
}

.happy-title {
  font-size: 2.5rem;
  color: #2d3748;
  margin-bottom: 15px;
  font-weight: 700;
  animation: bounce 1s ease-in-out;
}

.happy-text {
  font-size: 1.3rem;
  color: #4a5568;
  margin-bottom: 20px;
  animation: fadeInUp 1s ease-in-out 0.3s both;
}

.happy-emoji {
  font-size: 4rem;
  margin: 20px 0;
  animation: bounce 1s ease-in-out 0.6s both;
}

.happy-message {
  font-size: 1.1rem;
  color: #718096;
  margin-bottom: 10px;
  animation: fadeInUp 1s ease-in-out 0.9s both;
}

.happy-message:last-of-type {
  animation-delay: 1.2s;
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
  40% { transform: translateY(-20px); }
  60% { transform: translateY(-10px); }
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 结果区域样式 */
.result-container {
  width: 100%;
}

.result-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 40px 30px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
}

.result-title {
  font-size: 2rem;
  color: #2d3748;
  margin-bottom: 25px;
}

.result-content {
  margin-bottom: 30px;
}

.result-text {
  font-size: 1.2rem;
  color: #4a5568;
  line-height: 1.6;
  text-align: left;
}

.action-buttons {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.action-btn {
  padding: 15px 30px;
  border: none;
  border-radius: 25px;
  font-size: 1.1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.action-btn.primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.action-btn.primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
}

.action-btn.secondary {
  background: #e2e8f0;
  color: #4a5568;
}

.action-btn.secondary:hover {
  background: #cbd5e0;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .app {
    padding: 15px;
  }
  
  .title {
    font-size: 2rem;
  }
  
  .question-text {
    font-size: 1.3rem;
  }
  
  .option-btn {
    padding: 18px;
    font-size: 1rem;
  }
  
  .navigation {
    flex-direction: column;
  }
  
  .nav-btn {
    width: 100%;
  }
  
  .action-buttons {
    flex-direction: column;
  }
  
  .action-btn {
    width: 100%;
  }
}

@media (max-width: 480px) {
  .header,
  .question-card,
  .result-card {
    padding: 30px 20px;
  }
  
  .title {
    font-size: 1.8rem;
  }
  
  .question-text {
    font-size: 1.2rem;
  }
}
</style>
