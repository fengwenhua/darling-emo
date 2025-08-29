<template>
  <div class="app">
    <div class="container">
      <!-- 标题区域 -->
      <div class="header" v-if="currentStep === 0">
        <!-- 可爱的小狗遛狗动画 -->
        <div class="dog-walking-animation">
          <svg class="dog-svg" viewBox="0 0 500 300" xmlns="http://www.w3.org/2000/svg">
            <!-- 渐变定义 -->
            <defs>
              <linearGradient id="skyGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" style="stop-color:#87CEEB;stop-opacity:1" />
                <stop offset="100%" style="stop-color:#E0F6FF;stop-opacity:1" />
              </linearGradient>
              <linearGradient id="grassGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" style="stop-color:#90EE90;stop-opacity:1" />
                <stop offset="100%" style="stop-color:#32CD32;stop-opacity:1" />
              </linearGradient>
              <linearGradient id="husbandGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" style="stop-color:#FFB6C1;stop-opacity:1" />
                <stop offset="100%" style="stop-color:#FF69B4;stop-opacity:1" />
              </linearGradient>
              <linearGradient id="wifeGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" style="stop-color:#DDA0DD;stop-opacity:1" />
                <stop offset="100%" style="stop-color:#9370DB;stop-opacity:1" />
              </linearGradient>
              <linearGradient id="dogGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" style="stop-color:#F4A460;stop-opacity:1" />
                <stop offset="100%" style="stop-color:#D2691E;stop-opacity:1" />
              </linearGradient>
            </defs>
            
            <!-- 背景 -->
            <rect width="500" height="300" fill="url(#skyGradient)"/>
            <rect x="0" y="200" width="500" height="100" fill="url(#grassGradient)"/>
            
            <!-- 云朵 -->
            <g class="clouds">
              <g class="cloud" transform="translate(80, 50)">
                <ellipse cx="0" cy="0" rx="30" ry="18" fill="white" opacity="0.9"/>
                <ellipse cx="25" cy="-5" rx="20" ry="15" fill="white" opacity="0.9"/>
                <ellipse cx="-20" cy="-3" rx="18" ry="12" fill="white" opacity="0.9"/>
              </g>
              <g class="cloud" transform="translate(380, 40)">
                <ellipse cx="0" cy="0" rx="25" ry="15" fill="white" opacity="0.8"/>
                <ellipse cx="20" cy="-3" rx="18" ry="12" fill="white" opacity="0.8"/>
                <ellipse cx="-18" cy="-2" rx="15" ry="10" fill="white" opacity="0.8"/>
              </g>
              <g class="cloud" transform="translate(250, 35)">
                <ellipse cx="0" cy="0" rx="22" ry="14" fill="white" opacity="0.7"/>
                <ellipse cx="18" cy="-4" rx="16" ry="11" fill="white" opacity="0.7"/>
                <ellipse cx="-16" cy="-1" rx="14" ry="9" fill="white" opacity="0.7"/>
              </g>
            </g>
            
            <!-- 老公 -->
            <g class="husband" transform="translate(150, 180)">
              <!-- 头部 -->
              <circle cx="0" cy="0" r="18" fill="url(#husbandGradient)"/>
              <!-- 头发 -->
              <path d="M -15 -18 Q 0 -30 15 -18" fill="url(#husbandGradient)"/>
              <!-- 身体 -->
              <rect x="-16" y="18" width="32" height="40" fill="url(#husbandGradient)" rx="16"/>
              <!-- 手臂 -->
              <rect x="-25" y="22" width="10" height="28" fill="url(#husbandGradient)" rx="5" transform="rotate(-15, -25, 22)"/>
              <!-- 腿 -->
              <rect x="-10" y="58" width="8" height="22" fill="url(#husbandGradient)" rx="4"/>
              <rect x="2" y="58" width="8" height="22" fill="url(#husbandGradient)" rx="4"/>
              <!-- 眼睛 -->
              <circle cx="-6" cy="-4" r="2.5" fill="#333"/>
              <circle cx="6" cy="-4" r="2.5" fill="#333"/>
              <!-- 嘴巴 -->
              <path d="M -4 6 Q 0 10 4 6" stroke="#333" stroke-width="2" fill="none"/>
            </g>
            
            <!-- 老婆 -->
            <g class="wife" transform="translate(200, 180)">
              <!-- 头部 -->
              <circle cx="0" cy="0" r="13" fill="url(#wifeGradient)"/>
              <!-- 头发 -->
              <path d="M -12 -13 Q 0 -22 12 -13" fill="url(#wifeGradient)"/>
              <!-- 身体 -->
              <rect x="-10" y="13" width="20" height="28" fill="url(#wifeGradient)" rx="10"/>
              <!-- 手臂 -->
              <rect x="10" y="16" width="6" height="20" fill="url(#wifeGradient)" rx="3" transform="rotate(15, 10, 16)"/>
              <!-- 腿 -->
              <rect x="-6" y="41" width="5" height="16" fill="url(#wifeGradient)" rx="2.5"/>
              <rect x="1" y="41" width="5" height="16" fill="url(#wifeGradient)" rx="2.5"/>
              <!-- 眼睛 -->
              <circle cx="-4" cy="-2" r="1.8" fill="#333"/>
              <circle cx="4" cy="-2" r="1.8" fill="#333"/>
              <!-- 嘴巴 -->
              <path d="M -2 4 Q 0 6 2 4" stroke="#333" stroke-width="1.2" fill="none"/>
            </g>
            
            <!-- 遛狗绳 -->
            <path class="leash" d="M 200 175 Q 250 145 300 180" stroke="#8B4513" stroke-width="4" fill="none" stroke-linecap="round" stroke-dasharray="5,5"/>
            
            <!-- 可爱小狗 -->
            <g class="dog" transform="translate(300, 180)" @click="petDog" style="cursor: pointer;">
              <!-- 身体 -->
              <ellipse cx="0" cy="0" rx="25" ry="15" fill="url(#dogGradient)"/>
              <!-- 头部 -->
              <circle cx="20" cy="-10" r="18" fill="url(#dogGradient)"/>
              <!-- 耳朵 -->
              <ellipse cx="15" cy="-25" rx="6" ry="12" fill="#8B4513" transform="rotate(-20, 15, -25)"/>
              <ellipse cx="25" cy="-25" rx="6" ry="12" fill="#8B4513" transform="rotate(20, 25, -25)"/>
              <!-- 眼睛 -->
              <circle cx="23" cy="-12" r="3" fill="#333"/>
              <circle cx="17" cy="-12" r="3" fill="#333"/>
              <circle cx="23" cy="-12" r="1" fill="#fff"/>
              <circle cx="17" cy="-12" r="1" fill="#fff"/>
              <!-- 鼻子 -->
              <circle cx="30" cy="-6" r="2" fill="#000"/>
              <!-- 嘴巴 -->
              <path d="M 30 -4 Q 28 -1 26 -4" stroke="#000" stroke-width="2" fill="none"/>
              <!-- 舌头 -->
              <ellipse cx="28" cy="-1" rx="3" ry="2" fill="#FF69B4"/>
              <!-- 尾巴 -->
              <path class="tail" d="M -25 0 Q -40 -15 -30 -5" stroke="#8B4513" stroke-width="6" fill="none" stroke-linecap="round"/>
              <!-- 腿 -->
              <rect x="-20" y="12" width="5" height="12" fill="url(#dogGradient)" rx="2.5"/>
              <rect x="-10" y="12" width="5" height="12" fill="url(#dogGradient)" rx="2.5"/>
              <rect x="10" y="12" width="5" height="12" fill="url(#dogGradient)" rx="2.5"/>
              <rect x="15" y="12" width="5" height="12" fill="url(#dogGradient)" rx="2.5"/>
              <!-- 爪子 -->
              <circle cx="-20" cy="24" r="2" fill="#8B4513"/>
              <circle cx="-10" cy="24" r="2" fill="#8B4513"/>
              <circle cx="10" cy="24" r="2" fill="#8B4513"/>
              <circle cx="20" cy="24" r="2" fill="#8B4513"/>
            </g>
            
            <!-- 装饰元素 -->
            <g class="decorations">
              <!-- 小骨头 -->
              <g class="bone" transform="translate(350, 220)">
                <rect x="-8" y="-2" width="16" height="4" fill="#F4A460" rx="2"/>
                <rect x="-2" y="-8" width="4" height="16" fill="#F4A460" rx="2"/>
              </g>
              <!-- 小花朵 -->
              <g class="flower" transform="translate(80, 220)">
                <circle cx="0" cy="0" r="4" fill="#FF69B4"/>
                <circle cx="0" cy="0" r="3" fill="#FF1493"/>
                <circle cx="0" cy="0" r="2" fill="#FF1493"/>
              </g>
              <!-- 小蝴蝶 -->
              <g class="butterfly" transform="translate(420, 100)">
                <path d="M 0 0 Q -5 -5 -10 0 Q -5 5 0 0" fill="#FFB6C1"/>
                <path d="M 0 0 Q 5 -5 10 0 Q 5 5 0 0" fill="#FFB6C1"/>
              </g>
            </g>
            
            <!-- 交互提示 -->
            <g class="interaction-hint" transform="translate(300, 120)" @click="petDog" style="cursor: pointer;">
              <circle cx="0" cy="0" r="8" fill="#FFD700" opacity="0.8"/>
              <text x="0" y="3" text-anchor="middle" font-size="12" fill="#333" font-weight="bold">点击我</text>
            </g>
          </svg>
        </div>
        
        <!-- 小狗状态消息 -->
        <div v-if="dogState !== 'normal'" class="dog-message" :class="dogState">
          <span v-if="dogState === 'happy'">🐕 汪汪！好开心被你抚摸～</span>
          <span v-else-if="dogState === 'excited'">🐕 汪汪汪！超级兴奋！继续抚摸我吧！</span>
        </div>
        
        <h1 class="title">亲爱的老婆仔 💕</h1>
        <p class="subtitle">让我们一起走出emo困境吧</p>
        <div class="start-btn" @click="startQuiz">
          开始吧 ✨
        </div>
      </div>

      <!-- 问题区域 -->
      <div class="question-container" v-else-if="currentStep <= 2 || currentStep === 'work' || currentStep === 'study' || currentStep === 'life' || currentStep === 'work-salary' || currentStep === 'work-workload' || currentStep === 'work-change-job' || currentStep === 'study-seek-help' || currentStep === 'study-lower-goal' || currentStep === 'life-more-time' || currentStep === 'life-more-income'">
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
      dogState: 'normal', // 小狗状态：normal, happy, excited
      dogClickCount: 0, // 点击次数
      
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
            question: "为啥emo了呀？",
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
              question: "面对工作压力，你最希望发生什么？",
              options: [
                { 
                  text: "涨工资，让付出有回报 💰", 
                  value: "salary",
                  nextAction: "subflow",
                  subflowType: "work-salary"
                },
                { 
                  text: "少干点活，多休息 ⏰", 
                  value: "workload",
                  nextAction: "subflow",
                  subflowType: "work-workload"
                },
                { 
                  text: "换一份更轻松的工作 🔄", 
                  value: "change-job",
                  nextAction: "subflow",
                  subflowType: "work-change-job"
                }
              ]
            }
          ]
        },
        
        // 涨工资子流程
        workSalaryFlow: {
          title: "涨工资攻略 💰",
          questions: [
            {
              id: 4,
              question: "为了涨工资，你愿意付出什么努力？",
              options: [
              { 
                  text: "委婉的申请加薪 💰", 
                  value: "ask-for-raise",
                  nextAction: "result",
                  resultMessage: "委婉的提出，你现在工作量大，但是工资低，要求涨薪。"
                },
                { 
                  text: "提升技能，考取证书 📚", 
                  value: "improve-skills",
                  nextAction: "result",
                  resultMessage: "软考高级一过，直接就是专家。记住，投资自己永远不会亏本！"
                },
                { 
                  text: "主动承担更多责任 💪", 
                  value: "take-responsibility",
                  nextAction: "result",
                  resultMessage: "承担更多责任是涨工资的前提条件。当然，黑心资本家没良心，估计主动给你涨薪会很难！"
                },
                { 
                  text: "寻找跳槽机会，货比三家 🔍", 
                  value: "job-hunting",
                  nextAction: "result",
                  resultMessage: "先面试拿到offer，然后硬气点要求涨薪，不涨薪直接跳槽，跳槽才是涨薪的最快路径。记住，你值得更好的待遇！"
                }
              ]
            }
          ]
        },
        
        // 减少工作量子流程
        workWorkloadFlow: {
          title: "减少工作量攻略 ⏰",
          questions: [
            {
              id: 4,
              question: "如何减少工作量？",
              options: [
                { 
                  text: "提高工作效率，用工具自动化 🚀", 
                  value: "improve-efficiency",
                  nextAction: "result",
                  resultMessage: "选择提高效率很聪明！用更少的时间完成更多工作，这样既能减少压力，又能保持产出。"
                },
                { 
                  text: "学会拒绝，不接超出能力的工作 🚫", 
                  value: "learn-to-say-no",
                  nextAction: "result",
                  resultMessage: "干不了一点！不是所有工作都要接，保护自己的时间和精力很重要。"
                },
                { 
                  text: "和领导沟通，重新分配任务 🤝", 
                  value: "renegotiate-tasks",
                  nextAction: "result",
                  resultMessage: "选择和领导沟通很明智！不要担心领导会怎么想你，你只是合理表达你的诉求。"
                }
              ]
            }
          ]
        },
        
        // 换工作子流程
        workChangeJobFlow: {
          title: "换工作攻略 🔄",
          questions: [
            {
              id: 4,
              question: "换工作前，你会做什么准备？",
              options: [
                { 
                  text: "更新简历，提升技能 📝", 
                  value: "update-resume",
                  nextAction: "result",
                  resultMessage: "有空刷一下Boss直聘，看看现在的岗位什么薪资什么要求，先从简历修改开始吧～"
                },
                { 
                  text: "先找好下家，再辞职 🎯", 
                  value: "find-next-job",
                  nextAction: "result",
                  resultMessage: "选择先找好下家很稳妥！这样既能保证收入，也能有更多选择的空间。"
                },
                { 
                  text: "裸辞，给自己一个假期 🏖️", 
                  value: "quit-directly",
                  nextAction: "result",
                  resultMessage: "选择裸辞很有魄力！有时候需要给自己一个重新开始的机会，放心，有老公仔养你呀。"
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
                  text: "Call人啊！寻求导师帮助，获得专业指导 👨‍🏫", 
                  value: "seek-help",
                  nextAction: "subflow",
                  subflowType: "study-seek-help"
                },
                { 
                  text: "躺平吧！适当降低目标，减轻心理负担 🎯", 
                  value: "lower-goal",
                  nextAction: "subflow",
                  subflowType: "study-lower-goal"
                }
              ]
            }
          ]
        },
        
        // 寻求帮助子流程
        studySeekHelpFlow: {
          title: "寻求帮助攻略 👨‍🏫",
          questions: [
            {
              id: 4,
              question: "如何更好地寻求帮助？",
              options: [
                { 
                  text: "主动预约导师，准备具体问题 📝", 
                  value: "prepare-questions",
                  nextAction: "result",
                  resultMessage: "选择准备具体问题很专业！这样导师能更好地帮助你，效率会更高。记住，好的问题比好的答案更重要！"
                },
                { 
                  text: "找同学组队学习，互相督促 🤝", 
                  value: "study-group",
                  nextAction: "result",
                  resultMessage: "选择组队学习很棒！团队合作能激发灵感，互相督促也能提高学习效率。"
                },
                { 
                  text: "大喊一声，老公仔救命啊！！ 💗", 
                  value: "collective-wisdom",
                  nextAction: "result",
                  resultMessage: "老公仔会的 == 老婆仔会的！！"
                }
              ]
            }
          ]
        },
        
        // 降低目标子流程
        studyLowerGoalFlow: {
          title: "调整目标攻略 🎯",
          questions: [
            {
              id: 4,
              question: "如何科学地调整学习目标？",
              options: [
                { 
                  text: "重新评估优先级，专注最重要的 📊", 
                  value: "reprioritize",
                  nextAction: "result",
                  resultMessage: "选择重新评估优先级很明智！不是所有目标都同等重要，专注核心内容能让你学得更扎实。"
                },
                { 
                  text: "设定阶段性目标，循序渐进 🚀", 
                  value: "step-by-step",
                  nextAction: "result",
                  resultMessage: "选择循序渐进很棒！大目标分解成小目标，每完成一个都会给你成就感，压力也会慢慢减轻。"
                },
                { 
                  text: "给自己更多时间，不要急于求成 ⏰", 
                  value: "more-time",
                  nextAction: "result",
                  resultMessage: "选择给自己更多时间很明智！学习是一个过程，不要因为一时的压力而放弃。慢一点没关系，重要的是坚持。"
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
                  text: "去tmd工作学习，老娘要请假去看看世界 🕐", 
                  value: "more-time",
                  nextAction: "subflow",
                  subflowType: "life-more-time"
                },
                { 
                  text: "当卷王，接项目，挣小钱钱 💰", 
                  value: "more-income",
                  nextAction: "subflow",
                  subflowType: "life-more-income"
                }
              ]
            }
          ]
        },
        
        // 更多时间子流程
        lifeMoreTimeFlow: {
          title: "看世界攻略 🌍",
          questions: [
            {
              id: 4,
              question: "为了实现看世界的梦想，你愿意怎么做？",
              options: [
                { 
                  text: "制定旅行计划，设定具体目标 🗺️", 
                  value: "travel-plan",
                  nextAction: "result",
                  resultMessage: "选择制定旅行计划很棒！有目标才有动力，先从小地方开始，慢慢实现看世界的梦想。记住，每个伟大的旅程都始于第一步！"
                },
                { 
                  text: "学会时间管理，为旅行攒假期 ⏰", 
                  value: "time-management",
                  nextAction: "result",
                  resultMessage: "选择时间管理很明智！合理安排工作，高效完成任务，你就能有更多假期去看世界。时间就是金钱，更是自由！"
                },
                { 
                  text: "寻找远程工作机会，边工作边旅行 💻", 
                  value: "remote-work",
                  nextAction: "result",
                  resultMessage: "选择远程工作很有远见！科技让世界变小，你可以在任何地方工作，同时体验不同的文化和风景。这才是真正的自由！"
                }
              ]
            }
          ]
        },
        
        // 增加收入子流程
        lifeMoreIncomeFlow: {
          title: "增加收入攻略 💰",
          questions: [
            {
              id: 4,
              question: "如何安全地增加收入？",
              options: [
                { 
                  text: "寻找副业机会，多元化收入 💼", 
                  value: "side-business",
                  nextAction: "result",
                  resultMessage: "不是吧？不是吧？你还真的不够累，还要再接项目？"
                },
                { 
                  text: "理财投资，让钱生钱 📈", 
                  value: "investment",
                  nextAction: "result",
                  resultMessage: "算了吧，咱们没有这个天赋，还不如银行存定期～～"
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
      } else if (this.currentStep === "work-salary" || this.currentStep === "work-workload" || this.currentStep === "work-change-job") {
        // 工作压力子流程
        let flowKey
        if (this.currentStep === "work-salary") {
          flowKey = "workSalaryFlow"
        } else if (this.currentStep === "work-workload") {
          flowKey = "workWorkloadFlow"
        } else if (this.currentStep === "work-change-job") {
          flowKey = "workChangeJobFlow"
        }
        const flowQuestions = this.quizConfig[flowKey].questions
        const flowStep = this.answers.length - this.quizConfig.mainQuestions.length - 1 // 减去工作流程的第一题
        return flowQuestions[flowStep]
      } else if (this.currentStep === "study-seek-help" || this.currentStep === "study-lower-goal") {
        // 学习压力子流程
        let flowKey
        if (this.currentStep === "study-seek-help") {
          flowKey = "studySeekHelpFlow"
        } else if (this.currentStep === "study-lower-goal") {
          flowKey = "studyLowerGoalFlow"
        }
        const flowQuestions = this.quizConfig[flowKey].questions
        const flowStep = this.answers.length - this.quizConfig.mainQuestions.length - 1 // 减去学习流程的第一题
        return flowQuestions[flowStep]
      } else if (this.currentStep === "life-more-time" || this.currentStep === "life-more-income") {
        // 生活压力子流程
        let flowKey
        if (this.currentStep === "life-more-time") {
          flowKey = "lifeMoreTimeFlow"
        } else if (this.currentStep === "life-more-income") {
          flowKey = "lifeMoreIncomeFlow"
        }
        const flowQuestions = this.quizConfig[flowKey].questions
        const flowStep = this.answers.length - this.quizConfig.mainQuestions.length - 1 // 减去生活流程的第一题
        return flowQuestions[flowStep]
      }
      return null
    },
    
    currentFlowTitle() {
      if (this.currentStep === "work") return this.quizConfig.workFlow.title
      if (this.currentStep === "study") return this.quizConfig.studyFlow.title
      if (this.currentStep === "life") return this.quizConfig.lifeFlow.title
      if (this.currentStep === "work-salary") return this.quizConfig.workSalaryFlow.title
      if (this.currentStep === "work-workload") return this.quizConfig.workWorkloadFlow.title
      if (this.currentStep === "work-change-job") return this.quizConfig.workChangeJobFlow.title
      if (this.currentStep === "study-seek-help") return this.quizConfig.studySeekHelpFlow.title
      if (this.currentStep === "study-lower-goal") return this.quizConfig.studyLowerGoalFlow.title
      if (this.currentStep === "life-more-time") return this.quizConfig.lifeMoreTimeFlow.title
      if (this.currentStep === "life-more-income") return this.quizConfig.lifeMoreIncomeFlow.title
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
      console.log('nextQuestion called, currentStep:', this.currentStep, 'selectedOption:', this.selectedOption)
      
      if (this.selectedOption !== null) {
        const selectedOption = this.currentQuestion.options[this.selectedOption]
        console.log('selectedOption:', selectedOption)
        
        this.answers.push({
          question: this.currentQuestion.question,
          answer: selectedOption
        })
        
        console.log('nextAction:', selectedOption.nextAction, 'subflowType:', selectedOption.subflowType)
        
        // 根据选项的nextAction决定下一步
        if (selectedOption.nextAction === "happy") {
          console.log('Setting currentStep to happy')
          this.currentStep = "happy"
        } else if (selectedOption.nextAction === "subflow") {
          console.log('Setting currentStep to subflow:', selectedOption.subflowType)
          this.currentStep = selectedOption.subflowType
        } else if (selectedOption.nextAction === "result") {
          console.log('Setting currentStep to result')
          this.currentStep = "result"
        } else if (selectedOption.nextAction === "continue") {
          // 继续当前流程
          if (this.currentStep <= this.quizConfig.mainQuestions.length) {
            // 主流程
            if (this.currentStep < this.quizConfig.mainQuestions.length) {
              this.currentStep++
            }
          } else if (this.currentStep === "work") {
            // 工作流程（第3题）
            // 这里不需要继续，因为第3题已经选择了子流程
          } else if (this.currentStep === "work-salary" || this.currentStep === "work-workload" || this.currentStep === "work-change-job") {
            // 工作压力子流程
            let flowKey
            if (this.currentStep === "work-salary") {
              flowKey = "workSalaryFlow"
            } else if (this.currentStep === "work-workload") {
              flowKey = "workWorkloadFlow"
            } else if (this.currentStep === "work-change-job") {
              flowKey = "workChangeJobFlow"
            }
            const currentFlowQuestions = this.quizConfig[flowKey].questions
            const currentFlowStep = this.answers.length - this.quizConfig.mainQuestions.length - 1 // 减去工作流程的第一题
            
            if (currentFlowStep < currentFlowQuestions.length) {
              // 还有更多问题，继续
            } else {
              // 子流程完成，显示结果
              this.currentStep = "result"
            }
          } else {
            // 其他子流程
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
      if (this.currentStep > 1 || this.currentStep === "work" || this.currentStep === "study" || this.currentStep === "life" || this.currentStep === "work-salary" || this.currentStep === "work-workload" || this.currentStep === "work-change-job" || this.currentStep === "study-seek-help" || this.currentStep === "study-lower-goal" || this.currentStep === "life-more-time" || this.currentStep === "life-more-income" || this.currentStep === "result") {
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
        } else if (this.currentStep === "work-salary" || this.currentStep === "work-workload" || this.currentStep === "work-change-job") {
          // 从工作压力子流程返回
          console.log('Going back from work subflow')
          this.currentStep = "work"
          this.answers.pop()
          this.selectedOption = null
        } else if (this.currentStep === "study-seek-help" || this.currentStep === "study-lower-goal") {
          // 从学习压力子流程返回
          console.log('Going back from study subflow')
          this.currentStep = "study"
          this.answers.pop()
          this.selectedOption = null
        } else if (this.currentStep === "life-more-time" || this.currentStep === "life-more-income") {
          // 从生活压力子流程返回
          console.log('Going back from life subflow')
          this.currentStep = "life"
          this.answers.pop()
          this.selectedOption = null
        } else if (this.currentStep === "result") {
          // 从结果页返回，需要回到对应的子流程
          console.log('Going back from result page')
          const lastAnswer = this.answers[this.answers.length - 1]
          if (lastAnswer && lastAnswer.answer.value) {
            // 根据最后一个答案判断是哪个流程
            if (["improve-skills", "take-responsibility", "job-hunting"].includes(lastAnswer.answer.value)) {
              this.currentStep = "work-salary"
            } else if (["improve-efficiency", "learn-to-say-no", "renegotiate-tasks"].includes(lastAnswer.answer.value)) {
              this.currentStep = "work-workload"
            } else if (["update-resume", "find-next-job", "quit-directly"].includes(lastAnswer.answer.value)) {
              this.currentStep = "work-change-job"
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
      } else if (this.currentStep === "work-salary" || this.currentStep === "work-workload" || this.currentStep === "work-change-job") {
        // 工作压力子流程
        return this.quizConfig.mainQuestions.length + 2 // 第3题 + 第4题
      } else if (this.currentStep === "study-seek-help" || this.currentStep === "study-lower-goal") {
        // 学习压力子流程
        return this.quizConfig.mainQuestions.length + 2 // 第3题 + 第4题
      } else if (this.currentStep === "life-more-time" || this.currentStep === "life-more-income") {
        // 生活压力子流程
        return this.quizConfig.mainQuestions.length + 2 // 第3题 + 第4题
      }
      return 1
    },
    
    canGoBack() {
      if (this.currentStep <= 1) return false
      if (this.currentStep === "work" || this.currentStep === "study" || this.currentStep === "life" || this.currentStep === "work-salary" || this.currentStep === "work-workload" || this.currentStep === "work-change-job" || this.currentStep === "study-seek-help" || this.currentStep === "study-lower-goal" || this.currentStep === "life-more-time" || this.currentStep === "life-more-income") {
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
    },
    
    petDog() {
      this.dogClickCount++
      
      if (this.dogClickCount === 1) {
        this.dogState = 'happy'
        // 显示开心消息
        setTimeout(() => {
          this.dogState = 'normal'
        }, 2000)
      } else if (this.dogClickCount === 3) {
        this.dogState = 'excited'
        // 显示兴奋消息
        setTimeout(() => {
          this.dogState = 'normal'
        }, 3000)
      } else if (this.dogClickCount >= 5) {
        this.dogState = 'excited'
        // 显示超级兴奋消息
        setTimeout(() => {
          this.dogState = 'normal'
        }, 4000)
      }
      
      // 重置点击次数（每10次重置）
      if (this.dogClickCount >= 10) {
        this.dogClickCount = 0
      }
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
  
  .dog-walking-animation {
    margin-bottom: 20px;
  }
  
  .dog-svg {
    width: 280px;
    height: 140px;
  }
}

/* 小狗遛狗动画样式 */
.dog-walking-animation {
  margin-bottom: 30px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.dog-svg {
  width: 500px;
  height: 300px;
  filter: drop-shadow(0 8px 16px rgba(0, 0, 0, 0.15));
  border-radius: 20px;
  overflow: hidden;
}

/* 云朵动画 */
.clouds ellipse {
  animation: float 3s ease-in-out infinite;
}

.clouds ellipse:nth-child(1) {
  animation-delay: 0s;
}

.clouds ellipse:nth-child(2) {
  animation-delay: 1s;
}

.clouds ellipse:nth-child(3) {
  animation-delay: 2s;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-5px);
  }
}

/* 老公动画 */
.husband {
  animation: husbandWalk 2s ease-in-out infinite;
}

@keyframes husbandWalk {
  0%, 100% {
    transform: translate(150px, 180px) translateY(0px);
  }
  50% {
    transform: translate(150px, 180px) translateY(-3px);
  }
}

/* 老婆动画 */
.wife {
  animation: wifeWalk 2.2s ease-in-out infinite;
}

@keyframes wifeWalk {
  0%, 100% {
    transform: translate(200px, 180px) translateY(0px);
  }
  50% {
    transform: translate(200px, 180px) translateY(-2px);
  }
}

/* 遛狗绳动画 */
.leash {
  animation: leashWave 1.5s ease-in-out infinite;
  transform-origin: 200px 180px;
}

@keyframes leashWave {
  0%, 100% {
    transform: rotate(0deg);
  }
  50% {
    transform: rotate(2deg);
  }
}

/* 小狗动画 */
.dog {
  animation: dogWalk 2.5s ease-in-out infinite;
  transition: all 0.3s ease;
}

.dog:hover {
  transform: scale(1.05);
}

@keyframes dogWalk {
  0%, 100% {
    transform: translate(300px, 180px) translateY(0px) rotate(0deg);
  }
  25% {
    transform: translate(300px, 180px) translateY(-2px) rotate(1deg);
  }
  50% {
    transform: translate(300px, 180px) translateY(0px) rotate(0deg);
  }
  75% {
    transform: translate(300px, 180px) translateY(-2px) rotate(-1deg);
  }
}

/* 小狗尾巴动画 */
.tail {
  animation: tailWag 1s ease-in-out infinite;
  transform-origin: -25px 0px;
}

@keyframes tailWag {
  0%, 100% {
    transform: rotate(0deg);
  }
  50% {
    transform: rotate(20deg);
  }
}

/* 小狗耳朵动画 */
.dog ellipse {
  animation: earWiggle 2s ease-in-out infinite;
}

.dog ellipse:nth-child(2) {
  animation-delay: 0.5s;
}

@keyframes earWiggle {
  0%, 100% {
    transform: rotate(-20deg, 15, -25) scale(1);
  }
  50% {
    transform: rotate(-20deg, 15, -25) scale(1.1);
  }
}

.dog ellipse:nth-child(3) {
  animation-delay: 0.5s;
}

@keyframes earWiggle2 {
  0%, 100% {
    transform: rotate(20deg, 25, -25) scale(1);
  }
  50% {
    transform: rotate(20deg, 25, -25) scale(1.1);
  }
}

/* 装饰元素动画 */
.decorations rect {
  animation: bounce 2s ease-in-out infinite;
}

.decorations g {
  animation: rotate 4s linear infinite;
}

@keyframes bounce {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-3px);
  }
}

@keyframes rotate {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

/* 小狗眼睛闪烁动画 */
.dog circle:nth-child(4),
.dog circle:nth-child(5) {
  animation: blink 3s ease-in-out infinite;
}

@keyframes blink {
  0%, 90%, 100% {
    opacity: 1;
  }
  95% {
    opacity: 0.3;
  }
}

/* 小狗状态相关动画 */
.dog.happy .tail {
  animation: tailWag 0.5s ease-in-out infinite;
}

.dog.excited .tail {
  animation: tailWag 0.3s ease-in-out infinite;
}

.dog.happy ellipse {
  animation: earWiggle 1s ease-in-out infinite;
}

.dog.excited ellipse {
  animation: earWiggle 0.5s ease-in-out infinite;
}

/* 整体呼吸效果 */
.dog-walking-animation {
  animation: breathe 4s ease-in-out infinite;
}

@keyframes breathe {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.02);
  }
}

/* 小狗状态消息样式 */
.dog-message {
  background: linear-gradient(135deg, #FFD700, #FFA500);
  color: #333;
  padding: 12px 24px;
  border-radius: 25px;
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 20px;
  box-shadow: 0 4px 12px rgba(255, 215, 0, 0.3);
  animation: messagePop 0.5s ease-out;
  display: inline-block;
}

.dog-message.happy {
  background: linear-gradient(135deg, #90EE90, #32CD32);
  color: #fff;
  box-shadow: 0 4px 12px rgba(144, 238, 144, 0.3);
}

.dog-message.excited {
  background: linear-gradient(135deg, #FF69B4, #FF1493);
  color: #fff;
  box-shadow: 0 4px 12px rgba(255, 105, 180, 0.3);
  animation: messagePop 0.3s ease-out;
}

@keyframes messagePop {
  0% {
    transform: scale(0.8);
    opacity: 0;
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

/* 交互提示样式 */
.interaction-hint {
  animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
    opacity: 0.8;
  }
  50% {
    transform: scale(1.1);
    opacity: 1;
  }
}

/* 蝴蝶动画 */
.butterfly {
  animation: butterflyFly 4s ease-in-out infinite;
}

@keyframes butterflyFly {
  0%, 100% {
    transform: translate(420px, 100px) rotate(0deg);
  }
  25% {
    transform: translate(420px, 100px) rotate(15deg) translateY(-5px);
  }
  50% {
    transform: translate(420px, 100px) rotate(0deg) translateY(0px);
  }
  75% {
    transform: translate(420px, 100px) rotate(-15deg) translateY(-5px);
  }
}
</style>
