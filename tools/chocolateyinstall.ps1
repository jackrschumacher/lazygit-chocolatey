$ErrorActionPreference = 'Stop'

$packageName = 'lazygit'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '0.65.1'

# 1. 32-bit (x86) Variables
$url32      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_32-bit.zip"
$checksum32 = 'ec90b68d285438f871f754313eba1e28841f46b5b1aeff84f66f8a7917aeacde'

# 2. 64-bit (x64) Variables
$url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_x86_64.zip"
$checksum64 = 'bed669be29204932560836a58dc6519ba43c10ea7dc7df63af8a1d96424e191d'

# 3. ARM64 Variables (Overrides x64 if ARM architecture is detected)
$isArm64 = ($env:PROCESSOR_ARCHITECTURE -match 'ARM64') -or ($env:PROCESSOR_ARCHITEW6432 -match 'ARM64')

if ($isArm64) {
    $url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_arm64.zip"
    $checksum64 = 'eb2eff398864bc4888c1b8d2eb25a0d46727798c5eb599e8d9ec69be56edae05'
}

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  
  # Standard/32-bit mapping
  url            = $url32
  checksum       = $checksum32
  checksumType   = 'sha256'
  
  # 64-bit mapping (Handles both x64 and ARM64 via our logic above)
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs