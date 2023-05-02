git checkout main
git merge ft-proj --no-ff -m "feat(prj) cria prjs"
git branch -d ft-proj
git log --all --decorate --oneline --graph

