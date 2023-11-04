; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Administrador do Sistema Daros"

#define MyVersionNumber "0.0.1"
#define MyDtHCompile "01/11/2023 17:59:23"

#define MyAppVersion MyVersionNumber + " " + MyDtHCompile
#define MyAppPublisher "Daros"
#define MyAppURL "https://www.daros.com.br/"
#define MyAppExeName "Starter.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{E7B558F2-137C-4356-BA85-C737EF6E3592}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=c:\DarosPDV\
DisableDirPage=yes
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline
OutputDir=\\Vboxsvr\d_drive\inst\Bantu\
OutputBaseFilename=MercadoAtualiz
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

;[Tasks]
;Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
;atu
Source: "\\VBOXSVR\d_drive\inst\Bantu\Mercado\inst-Starter\Starter.exe"; DestDir: "{app}\Starter\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "\\VBOXSVR\d_drive\inst\Bantu\Mercado\inst-bin\*"; DestDir: "{app}\Starter\inst\inst-bin\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "\\Vboxsvr\d_drive\inst\Bantu\Mercado\Update\DBUpdates\*"; DestDir: "{app}\Starter\Update\DBUpdates\"; Flags: ignoreversion recursesubdirs createallsubdirs

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

;[Icons]
;Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\Starter\{#MyAppExeName}"
;Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\Starter\{#MyAppExeName}"; Tasks: desktopicon

[Run]
;fire 
;Filename: "{app}\Starter\inst\inst-Firebird\fb64\Firebird-4.0.2.2816-0-x64.exe"; Parameters: "/SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /COPYFBCLIENT /NOGDS32 /DIR=""{app}\Starter\inst\inst-Firebird\fb64\""";

;starter
Filename: "{app}\Starter\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

