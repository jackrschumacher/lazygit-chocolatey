$ErrorActionPreference = 'Stop'

$packageName = 'lazygit'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '0.65.0'

# 1. 32-bit (x86) Variables
$url32      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_32-bit.zip"
$checksum32 = 'bbc83aaa8ada679873da1629a591018ef49380a3b92f08957cf405a729eb8a0a'

# 2. 64-bit (x64) Variables
$url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_x86_64.zip"
$checksum64 = '20a597e8f29d4ed295e28fb4b869b31a41d20dc69dc15829c4744263141be2ee'

# 3. ARM64 Variables (Overrides x64 if ARM architecture is detected)
$isArm64 = ($env:PROCESSOR_ARCHITECTURE -match 'ARM64') -or ($env:PROCESSOR_ARCHITEW6432 -match 'ARM64')

if ($isArm64) {
    $url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_arm64.zip"
    $checksum64 = 'c0200d1481586b56996269d874be464c3c6e7c2ca47a283dd37316cffe6ece83'
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