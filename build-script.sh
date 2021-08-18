#!/bin/bash

echo "welcome to build script"
firstline=$(head -1 ./source/changelog.md)
# echo $firstline
read -a splitfirstline <<< $firstline
version=${splitfirstline[1]}
echo "You are building version number ${version}"
echo "enter '1' to continue and '0' to exit"
read versioncontinue
if [ $versioncontinue -eq 1 ]
then 
  for file in source/*
  do
    echo $file
    if [ $file == "source/secretinfo.md" ]
    then
      #echo "source/secretinfo.md will not be copied"
      cp $file build/
      sed -i 's/42/XX/g' build/secretinfo.md
    else
      echo "files are being copied"
      cp $file build/
    fi
  done
  cd build/
  echo "Build version $version contains:"
  ls
  echo "commiting the code"
  git add .
  git commit -m "$version changes commited"
  # We'll add more code here later
  cd ..
  echo "zipping the build folder"
  tar -czf build.gz build
else
  echo "Please come back when you are ready"
fi
