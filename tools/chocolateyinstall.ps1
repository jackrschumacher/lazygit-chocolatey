$ErrorActionPreference = 'Stop';

$packageName = 'lazygit'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version     = '0.61.1'
$url64       = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_Windows_x86_64.zip"
$checksum64  = '6024F3094904CAAF9B9672B801CBA31A65AD36729A0D2C5A03C432F739C0678B'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs