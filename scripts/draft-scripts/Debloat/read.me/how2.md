For the WindowsSysPrepDebloater.ps1 file, there are a couple of parameters that you can run so that you can specify which functions are used. The parameters are: -SysPrep, -Debloat and -Privacy.

To run this with parameters, do the following:

Download the .zip file on the main page of the GitHub and extract the .zip file to your desired location
Once extracted, open PowerShell (or PowerShell ISE) as an Administrator

On the prompt, change to the directory where you extracted the files:   e.g. - cd c:\temp
Next, to run either script, enter in the following:

Set-ExecutionPolicy Unrestricted -Force

e.g. - 
.\Windows10SysPrepDebloater.ps1 -Sysprep -Debloat -Privacy
