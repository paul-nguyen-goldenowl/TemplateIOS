# install
brew install swiftformat
npm install --global git-format-staged

# pre-commit
cp pre-commit .git/hooks/

# remove new file comment
mkdir -p ~/Library/Developer/Xcode/Templates/File\ Templates/Source
cp -R Custom\ File.xctemplate ~/Library/Developer/Xcode/Templates/File\ Templates/Source

