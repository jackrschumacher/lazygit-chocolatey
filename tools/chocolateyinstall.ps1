$ErrorActionPreference = 'Stop'

$packageName = 'lazygit'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '0.64.0'

# 1. 32-bit (x86) Variables
$url32      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_32-bit.zip"
$checksum32 = '5f6a35146fba35f51227fdaa96084d29288e608dcc74860243dde9918bcaf966'

# 2. 64-bit (x64) Variables
$url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_x86_64.zip"
$checksum64 = 'd8b723dd25e098c4a229e7d9a87ff1c3a5779902ebea242b8678f4ac195c1d90'

# 3. ARM64 Variables (Overrides x64 if ARM architecture is detected)
$isArm64 = ($env:PROCESSOR_ARCHITECTURE -match 'ARM64') -or ($env:PROCESSOR_ARCHITEW6432 -match 'ARM64')

if ($isArm64) {
    $url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_arm64.zip"
    $checksum64 = 'c126db1d2e02135307443b60f80c51a1cb30a1852f250e438fcb944866896bbd'
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