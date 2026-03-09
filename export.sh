dconf dump / > ~/linux_dotfiles/mint.conf
echo "exported"
git add .
git commit -m "sync"
git push origin main
