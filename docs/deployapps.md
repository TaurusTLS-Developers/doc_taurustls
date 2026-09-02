# Deploying Your TaurusTLS Applications
TaurusTLS relies on OpenSSL 3.x or 4.x. Depending on the target platform, OpenSSL is either linked dynamically (requiring DLLs) or statically (compiled into your executable).

You can download the correct binaries for all platforms here: [OpenSSL-Distribution Releases](https://github.com/TaurusTLS-Developers/OpenSSL-Distribution/releases)

## Dynamic Linking

### Linux

TaurusTLS uses **dynamic linking** for the Linux64 platform. On Linux, OpenSSL is usually installed by default on the OS. We recommend explicitly documenting this dependency for your end-users. If you choose to deploy a specific version, you can download redistributable Linux package from the [OpenSSL-Distribution Releases](https://github.com/TaurusTLS-Developers/OpenSSL-Distribution/releases) and redistribute it with your application(s).

### Windows

On Windows, TaurusTLS uses **Dynamic Linking**. You must redistribute the OpenSSL shared libraries (```.dll```) and the License file alongside your application executable.

You can use one of our automated installers.

#### InnoSetup Multi-Architecture Installer (```.exe```)

File pattern: ```openssl-<version>-Windows-installer.exe```

A single, unified setup executable that contains native binaries for x64, x86, and ARM64X:

- **Intelligent CPU Detection**: Automatically detects your processor architecture and installs the matching native binaries:
  - **64-bit Intel/AMD (x64)**: Installs native 64-bit OpenSSL runtime.
  - **64-bit ARM64 (Surface / Snapdragon)**: Installs native ARM64X OpenSSL runtime.
  - **32-bit (x86)**: Installs native 32-bit OpenSSL runtime.
- **32-bit Compatibility Option**: On 64-bit systems, you can check ```[x] 32-bit (x86) Compatibility Runtime``` to install 32-bit libraries alongside 64-bit libraries for legacy application compatibility (e.g., 32-bit Delphi/C++ applications).
- **Installation Modes & Standard Directories**:
  - Per-Machine (Admin / All Users)
    - 64-bit: ```C:\Program Files\TaurusTLS Developers\OpenSSL-<version>\```
    - 32-bit: ```C:\Program Files (x86)\TaurusTLS Developers\OpenSSL-<version>\```
  - Per-User (Current User / Non-Admin)
    - 64-bit: ```%LocalAppData%\Programs\TaurusTLS Developers\OpenSSL-<version>\x64\```
    - 32-bit: ```%LocalAppData%\Programs\TaurusTLS Developers\OpenSSL-<version>\x86\```
- **OpenSSL Command Prompt**: Adds a Start Menu shortcut that launches a command prompt session directly in the OpenSSL installation folder with PATH pre-configured.
- **Silent / Unattended Installation**:

```
:: Silent Per-Machine Install (All Users, Default)

openssl-3.4.0-Windows-installer.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART

:: Silent Per-User Install (Current User Only)

openssl-3.4.0-Windows-installer.exe /VERYSILENT /CURRENTUSER /SUPPRESSMSGBOXES /NORESTART
```
#### MSI Installer (Windows Installer)
Architecture-specific Windows Installer (<code>.msi</code>) packages for standard system-wide and enterprise software deployment:

- ```openssl-<version>-Windows-x64.msi```
- ```openssl-<version>-Windows-x86.msi```
- ```openssl-<version>-Windows-arm64.msi```

Key Features:

- **Administrative Installation**: Deploys binaries to standard system program directories versioned by Major.Minor (allowing different major releases to coexist while patch releases upgrade in-place):
  - 64-bit / ARM64: ```C:\Program Files\TaurusTLS Developers\OpenSSL-<major.minor>\```
  - 32-bit (x86): ```C:\Program Files (x86)\TaurusTLS Developers\OpenSSL-<major.minor>\```
- **32-bit Compatibility Feature (on x64)**: On 64-bit systems, you can select the optional ```32-bit (x86) Compatibility Runtime``` feature to install 32-bit libraries into ```Program Files (x86)``` for legacy 32-bit applications (e.g. 32-bit Delphi/C++ applications).
- **Configurable PATH**: Adding OpenSSL to the system ```PATH``` is provided as an optional sub-feature in the setup tree.
- **Start Menu Command Prompt**: Creates a Start Menu shortcut that launches Command Prompt directly in the installation directory with ```PATH``` pre-configured for the active architecture.

**Silent & Automated Installation**:
   
 To deploy silently via command line, scripts, or management tools (run as Administrator):
 
``` msiexec /i openssl-<version>-Windows-<arch>.msi /qn /norestart```

To perform a silent install with full verbose logging enabled:

```msiexec /i openssl-<version>-Windows-<arch>.msi /qn /norestart /l*v "openssl_install.log"```
 
#### MSIX Framework Packages (.msix)
File patterns:
- ```openssl-<version>-Windows-x64.msix```
- ```openssl-<version>-Windows-x86.msix```
- ```openssl-<version>-Windows-arm64.msix```

MSIX Framework packages provide isolated, shared runtime libraries for other Windows applications:
- **Isolated Deployment**: Installs directly to C:\Program Files\WindowsApps\ with complete architecture isolation.
- **MSIX App Dependency**: Consuming applications can reference OpenSSL in their AppxManifest.xml:

```
<Dependencies>
  <PackageDependency Name="TaurusTLS.OpenSSL" MinVersion="3.4.0.0" Publisher="CN=J. Peter Mugaas, O=J. Peter Mugaas, L=Lewisburg, S=wv, C=US" />
</Dependencies>
```
#### Manually Installing OpenSSL or Directly in You Own Installer

- **Download the OpenSSL Distribution**: Look for the standard packages (e.g., ```openssl-3.6.1-Windows-x86.zip```, ```openssl-3.6.1-Windows-x64.zip```, ```openssl-3.6.1-Windows-arm64.zip```).
- **Redistribution**: You must ship the following files with your application:

Platform | OpenSSL 3.x Release | OpenSSL 4.x Release |
-------------|-------------|-------------|
Windows 32-bit | libcrypto-3.dll, libssl-3.dll, LICENSE.txt | libcrypto-4.dll, libssl-4.dll, LICENSE.txt |
Windows 64-bit | libcrypto-3-x64.dll, libssl-3-x64.dll, LICENSE.txt | libcrypto-4-x64.dll, libssl-4-x64.dll, LICENSE.txt |
Windows ARM64X | libcrypto-3-arm64.dll, libssl-3-arm64.dll, LICENSE.txt | libcrypto-4-arm64.dll, libssl-4-arm64.dll, LICENSE.txt |

**Note**: We strongly recommend also redistributing the ```openssl.exe``` included in the package, as users may need it for certificate management tasks like:

- Generate keys
- Create Certificate Signing Requests
- Create self-signed Certificates
- Examine certificates
- convert Certificate
- etc

There's a reference book called the [OpenSSL Cookbook](https://www.feistyduck.com/books/openssl-cookbook/).
## Static Linking (Android, iOS, macOS)
On Mobile and macOS platforms, TaurusTLS uses Static Linking. The OpenSSL code is compiled directly into your application binary.

- **Download** the OpenSSL Distribution: Look for the standard packages (e.g., ```openssl-3.6.1-Android-arm64.zip```, ```openssl-3.6.1-iOS-arm64.zip```, ```openssl-3.6.1-macOS-arm64.zip```).
- **Development**: You need the static library files (.a) contained in the lib\static folder of these archives to compile your project.
- **Redistribution**: You do not need to ship any separate OpenSSL files (.dylib, .so, or .a). You only need to distribute:
  - Your Application package
  - The ```LICENSE.txt``` file (to comply with the OpenSSL license).
