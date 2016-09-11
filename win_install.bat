rmdir /S /Q "%HOMEDRIVE%%HOMEPATH%\vimfiles\"
mkdir "%HOMEDRIVE%%HOMEPATH%\vimfiles\"
xcopy /R /Y _vimrc "%HOMEDRIVE%%HOMEPATH%"
xcopy /E /Y vimfiles "%HOMEDRIVE%%HOMEPATH%\vimfiles\"
