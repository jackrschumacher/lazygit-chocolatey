$ErrorActionPreference = 'Stop';

$packageName = 'lazygit'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version     = '0.62.0'
$url64       = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_Windows_x86_64.zip"
$checksum64  = '132247de071b238cbcd40b0559de6ac248af7cbb97c1c93ae465537333286f04'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs