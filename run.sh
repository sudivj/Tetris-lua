echo "==> Building executable..."
zip -r Tetris.love -@ < filelist.txt
echo "==> Running..."
love Tetris.love
echo "==> Finished."