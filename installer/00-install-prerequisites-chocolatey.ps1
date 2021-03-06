 	Set-ExecutionPolicy Bypass

 	& taskkill /F /IM electron.exe /T /FI "STATUS eq RUNNING"
 	& taskkill /F /IM firefox.exe /T /FI "STATUS eq RUNNING"
 	& taskkill /F /IM chrome.exe /T /FI "STATUS eq RUNNING"
 	& taskkill /F /IM java.exe /T /FI "STATUS eq RUNNING"

	Remove-ItemProperty -ErrorAction silentlycontinue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -Name HATS
	
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    chocolatey install firefox -x86 --no-progress -y
    chocolatey install googlechrome nodejs-lts --no-progress -y
    chocolatey upgrade googlechrome nodejs-lts firefox --no-progress -y
    chocolatey uninstall jdk8 python2 --no-progress -y > $null
    
	# if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit") {
    #     Remove-Item -Recurse -Force -ErrorAction silentlycontinue "${Env:ProgramFiles(x86)}\hats"
	#  }
	#  else {
	#     Remove-Item -Recurse -Force -ErrorAction silentlycontinue "${Env:ProgramFiles}\hats"
	# 	}

	Remove-Item -Recurse -Force -ErrorAction silentlycontinue "${Env:temp}\testpage"

    refreshenv
    echo $env:path

    cd ../../hats
    Remove-Item -Recurse -Force -ErrorAction silentlycontinue "node_modules"
    & npm install
  # Start-Process cmd -verb runAs "/C cd $pwd && npm start & exit "
    cd ../..
