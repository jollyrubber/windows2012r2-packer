if not exist "C:\Windows\Temp\7z920-x64.msi" (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/7z920-x64.msi', 'C:\Windows\Temp\7z920-x64.msi')" <NUL
)
msiexec /qb /i C:\Windows\Temp\7z920-x64.msi

if "%PACKER_BUILDER_TYPE%" equ "virtualbox-iso" goto :virtualbox
goto :done

:virtualbox

move /Y C:\Users\vagrant\VBoxGuestAdditions.iso C:\Windows\Temp
cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox"

if exist a:\oracle-vbox.cer (
  copy a:\oracle-vbox.cer C:\Users\vagrant\.ssh\authorized_keys
) else (
	cmd /c certutil -addstore -f "TrustedPublisher" C:\Windows\Temp\virtualbox\cert\oracle-vbox.cer
)

cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
goto :done

:done
msiexec /qb /x C:\Windows\Temp\7z920-x64.msi