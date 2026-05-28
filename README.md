# Lazygit Native Chocolatey Package

[![GitHub Release](https://img.shields.io/github/v/release/jackrschumacher/lazygit-chocolatey)](https://github.com/jackrschumacher/lazygit-chocolatey) 

This repository contains the build scripts for a native Windows Chocolatey package of [lazygit](https://github.com/jesseduffield/lazygit), a simple terminal UI for git commands. 


---

## How to Install

**Prerequisites:** You must have [Chocolatey](https://chocolatey.org/install) installed and be running an elevated PowerShell prompt (Run as Administrator).

1. Go to the **[Releases](../../releases)** page of this repository.	
2. Download the latest `lazygit.<version>.nupkg` file (e.g., `lazygit.0.61.1.nupkg`).
3. Open an Administrator PowerShell prompt in the folder where you downloaded the file (usually your Downloads folder).
4. Run the local install command:
   ```powershell
   choco install lazygit -s . -y
   ```
5. Upgrading:
      ```powershell
      choco upgrade lazygit -s . -y
      ```

## How to Release an Update (Maintainer Guide)

When a new version of lazygit drops, follow these steps to update the package:

### 1. Update the Version Number
Open `lazygit.nuspec` and update the `<version>` tag to match the new release.

### 2. Fetch the New Checksum
Find the Windows x86_64 SHA256 hash from the official lazygit releases - it is often in the `checksums.txt` file in the releases page. You can extract it using PowerShell (replace `0.62.0` with the target version):
```powershell
$version = "0.62.0"
$url = "[https://github.com/jesseduffield/lazygit/releases/download/v$version/checksums.txt](https://github.com/jesseduffield/lazygit/releases/download/v$version/checksums.txt)"
(Invoke-WebRequest $url).Content -split "`n" | Select-String "Windows_x86_64.zip"
```

### Pack the .nuspec
```powershell
choco pack lazygit.nuspec
```