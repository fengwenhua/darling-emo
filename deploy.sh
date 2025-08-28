#!/bin/bash

echo "🚀 开始构建 darling-emo 应用..."

# 构建应用
pnpm run build

if [ $? -eq 0 ]; then
    echo "✅ 构建成功！"
    echo "📁 构建文件位于 dist/ 目录"
    echo ""
    echo "🌐 部署选项："
    echo "1. GitHub Pages: 将 dist/ 目录内容推送到 gh-pages 分支"
    echo "2. Netlify: 拖拽 dist/ 目录到 Netlify 部署页面"
    echo "3. Vercel: 连接 GitHub 仓库自动部署"
    echo "4. 自建服务器: 将 dist/ 目录内容上传到服务器"
    echo ""
    echo "💡 提示：dist/ 目录包含所有静态文件，可以直接部署到任何静态托管平台"
else
    echo "❌ 构建失败，请检查错误信息"
    exit 1
fi
