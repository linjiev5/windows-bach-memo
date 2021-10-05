set /p p=番号

set date=%date:~,10%
set fileName=ST1_%p%_エビデンス_%date:/=%.xls
 
set filePath=C:\Users\alinj\OneDrive - ahqb\Desktop\新しいフォルダー\
cd ./%filePath%
echo 2> %fileName%