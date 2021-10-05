set /p p=番号

set date=%date:~,10%
set fileName=ST1_%p%_エビデンス_%date:/=%.xlsx
 
ren "新規 Microsoft Excel ワークシート.xlsx" %fileName%