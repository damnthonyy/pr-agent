#!/bin/bash
# scripts/sync-with-upstream.sh

set -e

echo "📦 Synchronisation with upstream..."

# 1. update main
echo "1️⃣  Updating main branch with upstream changes..."
git checkout main
git fetch upstream
git merge upstream/main --no-edit
git push origin main

# 2. merge to prod
echo "2️⃣  merge main into prod..."
git checkout production
git merge main

# 3. Resolve conflicts if any
if [ $? -ne 0 ]; then
  echo "⚠️  Conflits on merge detected! Please resolve them manually:"
  echo "   git status          # Voir les fichiers en conflit"
  echo "   # Editez les fichiers"
  echo "   git add ."
  echo "   git commit -m 'chore: resolve merge conflicts'"
  echo "   git push origin production"
  exit 1
fi

git push origin production
echo "✅ Sync is complete! Upstream changes have been merged into production."