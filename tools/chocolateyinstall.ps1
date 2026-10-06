$ErrorActionPreference = 'Stop'

$packageName = 'lazygit'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '0.66.0'

# 1. 32-bit (x86) Variables
$url32      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_32-bit.zip"
$checksum32 = 'ed067613bef886f3c28daa2170fa24e58db4719de04fd7b14afa29d95f17b015'

# 2. 64-bit (x64) Variables
$url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_x86_64.zip"
$checksum64 = 'ed8fab4af7b8bac474084e976214a96569dea841c9f9b293502b83d8c3163e4b'

# 3. ARM64 Variables (Overrides x64 if ARM architecture is detected)
$isArm64 = ($env:PROCESSOR_ARCHITECTURE -match 'ARM64') -or ($env:PROCESSOR_ARCHITEW6432 -match 'ARM64')

if ($isArm64) {
    $url64      = "https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_windows_arm64.zip"
    $checksum64 = '53be33b36dc83b32aff317e317c7b34495ab8c15d4360db7ba56b12b05e7d157'
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