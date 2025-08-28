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
      <div class="question-container" v-else-if="currentStep <= 2 || currentStep === 'work' || currentStep === 'study' || currentStep === 'life'">
        <div class="question-card">
          <div class="question-number">第 {{ getQuestionNumber() }} 题</div>
          <div v-if="currentFlowTitle" class="flow-title">{{ currentFlowTitle }}</div>
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
              v-if="canGoBack()" 
              class="nav-btn prev-btn"
              @click="prevQuestion"
            >
              ← 上一题
            </button>
          </div>
        </div>
      </div>

      <!-- 温馨动画区域 -->
      <div class="happy-container" v-else-if="currentStep === 'happy'">
        <div class="happy-card">
          <h2 class="happy-title">🎉 太棒啦！</h2>
          <p class="happy-text">老婆仔心情不错呢～</p>
          <div class="happy-emoji">😊</div>
          <p class="happy-message">继续保持这份好心情吧！</p>
          
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
      
      // 🎯 所有题目配置 - 在这里修改题目内容
      quizConfig: {
        // 主流程题目
        mainQuestions: [
          {
            id: 1,
            question: "是不是最近emo啦？😔",
            options: [
              { 
                text: "是 😢", 
                value: "yes",
                nextAction: "continue"
              },
              { 
                text: "否 😊", 
                value: "no",
                nextAction: "happy"
              }
            ]
          },
          {
            id: 2,
            question: "主要是什么原因让你emo呢？",
            options: [
              { 
                text: "工作压力大 💼", 
                value: "work",
                nextAction: "subflow",
                subflowType: "work"
              },
              { 
                text: "学习压力大 📚", 
                value: "study",
                nextAction: "subflow",
                subflowType: "study"
              },
              { 
                text: "生活压力大 🏠", 
                value: "life",
                nextAction: "subflow",
                subflowType: "life"
              }
            ]
          }
        ],
        
        // 工作压力子流程
        workFlow: {
          title: "工作压力解决方案 💼",
          questions: [
            {
              id: 3,
              question: "面对工作压力，你最希望发生什么改变？",
              options: [
                { 
                  text: "涨工资，让付出有回报 💰", 
                  value: "salary",
                  nextAction: "continue"
                },
                { 
                  text: "减少工作量，有更多休息时间 ⏰", 
                  value: "workload",
                  nextAction: "continue"
                },
                { 
                  text: "换一份更轻松的工作 🔄", 
                  value: "change-job",
                  nextAction: "continue"
                }
              ]
            },
            {
              id: 4,
              question: "如果领导不涨薪但继续增加工作量，你会？",
              options: [
                { 
                  text: "默默接受，自愿加班 😔", 
                  value: "accept",
                  nextAction: "result",
                  resultMessage: "选择默默接受加班，虽然体现了你的责任心，但这样下去你会越来越累。记住，你的时间和精力也是宝贵的！"
                },
                { 
                  text: "接受现实，但绝不加班 ⚡", 
                  value: "no-overtime",
                  nextAction: "result",
                  resultMessage: "选择不加班是对的！工作只是生活的一部分，你有权利享受属于自己的时间。"
                },
                { 
                  text: "委婉沟通，寻求理解 🤝", 
                  value: "communicate",
                  nextAction: "result",
                  resultMessage: "选择沟通是明智的！委婉地表达你的想法，让领导了解你的处境，这是解决问题的好方法。"
                },
                { 
                  text: "硬气谈判，不涨薪就不干 💪", 
                  value: "negotiate",
                  nextAction: "result",
                  resultMessage: "选择硬气谈判很有勇气！记住，你有选择的权利，不要害怕为自己争取应得的权益。"
                }
              ]
            }
          ]
        },
        
        // 学习压力子流程
        studyFlow: {
          title: "学习压力解决方案 📚",
          questions: [
            {
              id: 3,
              question: "面对学习压力，你最希望发生什么改变？",
              options: [
                { 
                  text: "调整学习计划，更合理安排时间 📅", 
                  value: "adjust-plan",
                  nextAction: "continue"
                },
                { 
                  text: "寻求导师帮助，获得专业指导 👨‍🏫", 
                  value: "seek-help",
                  nextAction: "continue"
                },
                { 
                  text: "适当降低目标，减轻心理负担 🎯", 
                  value: "lower-goal",
                  nextAction: "continue"
                }
              ]
            },
            {
              id: 4,
              question: "当学习压力让你喘不过气时，你会？",
              options: [
                { 
                  text: "咬牙坚持，熬夜学习 😰", 
                  value: "persist",
                  nextAction: "result",
                  resultMessage: "选择咬牙坚持虽然很有毅力，但要注意劳逸结合。学习是一个长期过程，保持身心健康更重要！"
                },
                { 
                  text: "合理安排时间，劳逸结合 ⏰", 
                  value: "balance",
                  nextAction: "result",
                  resultMessage: "选择劳逸结合非常明智！合理安排时间，既能学习又能休息，这样效率会更高。"
                },
                { 
                  text: "寻求同学帮助，共同进步 🤝", 
                  value: "collaborate",
                  nextAction: "result",
                  resultMessage: "选择寻求帮助是聪明的做法！学习不是一个人的战斗，和同学一起进步会更有动力。"
                },
                { 
                  text: "调整心态，享受学习过程 😊", 
                  value: "enjoy",
                  nextAction: "result",
                  resultMessage: "选择享受学习过程很棒！保持积极心态，把学习当作成长的机会，压力就会变成动力。"
                }
              ]
            }
          ]
        },
        
        // 生活压力子流程
        lifeFlow: {
          title: "生活压力解决方案 🏠",
          questions: [
            {
              id: 3,
              question: "面对生活压力，你最希望发生什么改变？",
              options: [
                { 
                  text: "有更多自由时间，做自己喜欢的事 🕐", 
                  value: "more-time",
                  nextAction: "continue"
                },
                { 
                  text: "改善居住环境，让生活更舒适 🏡", 
                  value: "better-home",
                  nextAction: "continue"
                },
                { 
                  text: "增加收入来源，减轻经济压力 💰", 
                  value: "more-income",
                  nextAction: "continue"
                }
              ]
            },
            {
              id: 4,
              question: "当生活压力让你感到疲惫时，你会？",
              options: [
                { 
                  text: "默默承受，不告诉别人 😔", 
                  value: "suffer",
                  nextAction: "result",
                  resultMessage: "选择默默承受不是好办法，你不需要一个人承担所有压力。家人朋友都很关心你，寻求帮助是勇敢的表现！"
                },
                { 
                  text: "寻求家人朋友支持 💕", 
                  value: "seek-support",
                  nextAction: "result",
                  resultMessage: "选择寻求支持很明智！家人朋友是你最坚强的后盾，和他们分享困难，一起想办法解决。"
                },
                { 
                  text: "制定计划，逐步改善 📋", 
                  value: "make-plan",
                  nextAction: "result",
                  resultMessage: "选择制定计划很有条理！把大问题分解成小目标，一步一步来，压力就会慢慢减轻。"
                },
                { 
                  text: "适当放松，给自己奖励 🎁", 
                  value: "reward",
                  nextAction: "result",
                  resultMessage: "选择给自己奖励很棒！生活需要仪式感，适当放松和奖励自己，让生活更有盼头。"
                }
              ]
            }
          ]
        }
      }
    }
  },
  
  computed: {
    currentQuestion() {
      if (this.currentStep <= this.quizConfig.mainQuestions.length) {
        return this.quizConfig.mainQuestions[this.currentStep - 1]
      } else if (this.currentStep === "work") {
        const workStep = this.answers.length - this.quizConfig.mainQuestions.length
        return this.quizConfig.workFlow.questions[workStep]
      } else if (this.currentStep === "study") {
        const studyStep = this.answers.length - this.quizConfig.mainQuestions.length
        return this.quizConfig.studyFlow.questions[studyStep]
      } else if (this.currentStep === "life") {
        const lifeStep = this.answers.length - this.quizConfig.mainQuestions.length
        return this.quizConfig.lifeFlow.questions[lifeStep]
      }
      return null
    },
    
    currentFlowTitle() {
      if (this.currentStep === "work") return this.quizConfig.workFlow.title
      if (this.currentStep === "study") return this.quizConfig.studyFlow.title
      if (this.currentStep === "life") return this.quizConfig.lifeFlow.title
      return ""
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
        const selectedOption = this.currentQuestion.options[this.selectedOption]
        
        this.answers.push({
          question: this.currentQuestion.question,
          answer: selectedOption
        })
        
        // 根据选项的nextAction决定下一步
        if (selectedOption.nextAction === "happy") {
          this.currentStep = "happy"
        } else if (selectedOption.nextAction === "subflow") {
          this.currentStep = selectedOption.subflowType
        } else if (selectedOption.nextAction === "result") {
          this.currentStep = "result"
        } else if (selectedOption.nextAction === "continue") {
          // 继续当前流程
          if (this.currentStep <= this.quizConfig.mainQuestions.length) {
            // 主流程
            if (this.currentStep < this.quizConfig.mainQuestions.length) {
              this.currentStep++
            }
          } else {
            // 子流程
            const currentFlow = this.currentStep
            const currentFlowQuestions = this.quizConfig[`${currentFlow}Flow`].questions
            const currentFlowStep = this.answers.length - this.quizConfig.mainQuestions.length
            
            if (currentFlowStep < currentFlowQuestions.length) {
              // 还有更多问题，继续
            } else {
              // 子流程完成，显示结果
              this.currentStep = "result"
            }
          }
        }
        
        this.selectedOption = null
      }
    },
    
    prevQuestion() {
      console.log('prevQuestion called, currentStep:', this.currentStep, 'answers length:', this.answers.length)
      
      // 检查是否可以返回（包括子流程）
      if (this.currentStep > 1 || this.currentStep === "work" || this.currentStep === "study" || this.currentStep === "life" || this.currentStep === "result") {
        // 如果在子流程中，需要特殊处理
        if (this.currentStep === "work" || this.currentStep === "study" || this.currentStep === "life") {
          const currentFlow = this.currentStep
          const currentFlowQuestions = this.quizConfig[`${currentFlow}Flow`].questions
          const currentFlowStep = this.answers.length - this.quizConfig.mainQuestions.length
          
          console.log('In subflow:', currentFlow, 'step:', currentFlowStep)
          
          if (currentFlowStep > 0) {
            // 还在子流程中，返回上一题
            console.log('Going back in subflow')
            this.answers.pop()
            this.selectedOption = null
          } else {
            // 回到主流程第二题
            console.log('Going back to main flow')
            this.currentStep = 2
            this.answers.pop()
            this.selectedOption = null
          }
        } else if (this.currentStep === "result") {
          // 从结果页返回，需要回到对应的子流程
          console.log('Going back from result page')
          const lastAnswer = this.answers[this.answers.length - 1]
          if (lastAnswer && lastAnswer.answer.value) {
            // 根据最后一个答案判断是哪个流程
            if (["accept", "no-overtime", "communicate", "negotiate"].includes(lastAnswer.answer.value)) {
              this.currentStep = "work"
            } else if (["persist", "balance", "collaborate", "enjoy"].includes(lastAnswer.answer.value)) {
              this.currentStep = "study"
            } else if (["suffer", "seek-support", "make-plan", "reward"].includes(lastAnswer.answer.value)) {
              this.currentStep = "life"
            }
          }
          this.answers.pop()
          this.selectedOption = null
        } else {
          // 主流程中的返回
          console.log('Going back in main flow')
          this.currentStep--
          this.answers.pop()
          this.selectedOption = null
        }
      } else {
        console.log('Cannot go back, currentStep <= 1')
      }
    },
    
    getQuestionNumber() {
      if (this.currentStep <= this.quizConfig.mainQuestions.length) {
        return this.currentStep
      } else if (this.currentStep === "work" || this.currentStep === "study" || this.currentStep === "life") {
        return this.quizConfig.mainQuestions.length + this.answers.length - this.quizConfig.mainQuestions.length + 1
      }
      return 1
    },
    
    canGoBack() {
      if (this.currentStep <= 1) return false
      if (this.currentStep === "work" || this.currentStep === "study" || this.currentStep === "life") {
        // 在子流程中，总是可以返回（因为至少已经选择了压力源）
        return true
      }
      if (this.currentStep === "result") {
        // 在结果页，总是可以返回
        return true
      }
      return true
    },
    
    getResultText() {
      const lastAnswer = this.answers[this.answers.length - 1]
      
      if (lastAnswer && lastAnswer.answer.resultMessage) {
        return lastAnswer.answer.resultMessage
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
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.container {
  width: 100%;
  max-width: 600px;
  text-align: center;
}

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

.flow-title {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
  color: white;
  padding: 8px 20px;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
  display: inline-block;
  margin-bottom: 15px;
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
  justify-content: center;
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

.happy-container, .result-container {
  width: 100%;
}

.happy-card, .result-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 20px;
  padding: 40px 30px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  text-align: center;
}

.happy-title, .result-title {
  font-size: 2rem;
  color: #2d3748;
  margin-bottom: 25px;
}

.happy-text, .happy-message {
  font-size: 1.2rem;
  color: #4a5568;
  margin-bottom: 15px;
}

.happy-emoji {
  font-size: 4rem;
  margin: 20px 0;
}

.result-text {
  font-size: 1.2rem;
  color: #4a5568;
  line-height: 1.6;
  text-align: left;
  margin-bottom: 30px;
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
  
  .action-btn {
    width: 100%;
  }
}
</style>
