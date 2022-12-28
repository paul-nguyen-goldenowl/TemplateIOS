# exit when any command fails
set -e

if [[ $# -lt 1 ]]; then
    echo "Usage: bash init.sh my.new.package" >&2
    exit 2
fi

PACKAGE=$1
APPNAME=$(echo $PACKAGE | rev | cut -d "." -f 1 | rev)

# Rename package
echo "Renaming packages to $PACKAGE name=$APPNAME"
find . -type f -not -path "./.git/*" -not -path "./init/*" -exec sed -i.bak "s/com.ln.TemplateIOS/$PACKAGE/g" {} \;
find . -type f -not -path "./.git/*" -not -path "./init/*" -exec sed -i.bak "s/TemplateIOS/$APPNAME/g" {} \;

# Cleaning
echo "Cleaning up"
find . -name "*.bak" -type f -delete
find . -name "*.DS_Store" -type f -delete

# directories
mv TemplateIOS ${APPNAME}
mv TemplateIOS.xcodeproj ${APPNAME}.xcodeproj

# Remove additional files
echo "Removing additional files"
rm -rf .git/

# install
brew install swiftformat
npm install --global git-format-staged

# pod
echo "Installing Pod ..."
pod install

# pre-commit
git init .
# git add .
# git commit -m "init project"

# cp init/pre-commit .git/hooks/
# chmod +x .git/hooks/pre-commit

# remove new file comment
# mkdir -p ~/Library/Developer/Xcode/Templates/File\ Templates/Source
# cp -R init/Custom\ File.xctemplate ~/Library/Developer/Xcode/Templates/File\ Templates/Source

rm -rf init

echo "Done!"
