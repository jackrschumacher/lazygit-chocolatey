$ErrorActionPreference = 'Stop'

$packageName = 'lazygit'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '0.63.1'

# 1. 32-bit (x86) Variables
$url32      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_32-bit.zip"
$checksum32 = 'b95f0a112071f4095a41f6165e86afc2ef0e0cd7da72f8496453f13d7598ab13'

# 2. 64-bit (x64) Variables
$url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_x86_64.zip"
$checksum64 = '230721fb5f0d5c0e91555bd4bd76f5213477b116027f1c0fe222b70d49f58ea0'

# 3. ARM64 Variables (Overrides x64 if ARM architecture is detected)
$isArm64 = ($env:PROCESSOR_ARCHITECTURE -match 'ARM64') -or ($env:PROCESSOR_ARCHITEW6432 -match 'ARM64')

if ($isArm64) {
    $url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_arm64.zip"
    $checksum64 = '8ced1a9e788cb9b5a8e27f61080ceecede0d76e86fb8ed74d882d2982d480458'
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