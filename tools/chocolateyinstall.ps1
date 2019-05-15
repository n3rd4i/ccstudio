$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = "$env:ChocolateyPackageName.zip"
  unzipLocation = "$env:TEMP"
  url           = 'http://software-dl.ti.com/ccs/esd/CCSv9/CCS_9_0_0/exports/CCS9.0.1.00004_win64.zip'
  softwareName  = 'ccstudio*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = '09B63C7BC8D0A9C144547D9ACADEA007'
  checksumType  = 'md5' #default is md5, can also be sha1, sha256 or sha512
}
Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package

$installerLocation = Join-Path $env:TEMP 'CCS9.0.1.00004_win64'
$responseFile = Join-Path $toolsDir 'response.txt'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType = 'exe'
  file = Join-Path $installerLocation 'ccs_setup_win64_9.0.1.00004.exe'
  # silentArgs    = "--save-response-file %cd%\response.txt --skip-install true"
  silentArgs    = "--mode unattended --response-file $responseFile"
  validExitCodes= @(0, 3010, 1641)
  softwareName  = 'ccstudio*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
}
Install-ChocolateyInstallPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-install-package
