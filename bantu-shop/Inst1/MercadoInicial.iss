; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Administrador do Sistema Daros"

#define MyVersionNumber "0.0.1"
#define MyDtHCompile "01/11/2023 17:59:23"
#define FBInst "Firebird-4.0.3.2975-0-x64.exe"

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
OutputBaseFilename=MercadoInicial
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; ------- iniciais

;bin redist
Source: "\\VBOXSVR\d_drive\inst\Bantu\Mercado\inst-Delphi-redist\Redist\win64\*"; DestDir: "{app}\Bin\"; Flags: ignoreversion recursesubdirs createallsubdirs

;copia instalador firebird
Source: "\\VBOXSVR\d_drive\inst\Bantu\Mercado\inst-Firebird\fb64\{#FBInst}"; DestDir: "{app}\Starter\inst\inst-Firebird\fb64\"; Flags: ignoreversion recursesubdirs createallsubdirs

;fdb zerados
Source: "\\Vboxsvr\d_drive\inst\Bantu\Mercado\inst-Firebird\dados\*"; DestDir: "{app}\Starter\inst\inst-Firebird\dados\"; Flags: ignoreversion recursesubdirs createallsubdirs

;copia zerados para a Dados\
Source: "\\Vboxsvr\d_drive\inst\Bantu\Mercado\inst-Firebird\dados\retag464.FDB"; DestDir: "{app}\Dados\"; DestName: "Retag.fdb"; Flags: ignoreversion 


; ---- atualizacao

;copia starter.exe para uso
Source: "\\VBOXSVR\d_drive\inst\Bantu\Mercado\inst-Starter\Starter.exe"; DestDir: "{app}\Starter\"; Flags: ignoreversion recursesubdirs createallsubdirs

;nao copia exe direto para a bin, copia para inst e starter decide
Source: "\\VBOXSVR\d_drive\inst\Bantu\Mercado\inst-bin\*"; DestDir: "{app}\Starter\inst\inst-bin\"; Flags: ignoreversion recursesubdirs createallsubdirs

;txt atualizadores do banco
Source: "\\Vboxsvr\d_drive\inst\Bantu\Mercado\Update\DBUpdates\*"; DestDir: "{app}\Starter\Update\DBUpdates\"; Flags: ignoreversion recursesubdirs createallsubdirs

; NOTE: Don't use "Flags: ignoreversion" on any shared system files
[Run]
;md
Filename: "{cmd}"; Parameters: "/C md {app}"; Flags: runhidden
Filename: "{cmd}"; Parameters: "/C md {app}\Dados"; Flags: runhidden

;firebird
;Filename: "{app}\Starter\inst\inst-Firebird\fb64\{#FBInst}"; Description: "Firebird"; Flags: runascurrentuser
;Filename: "{app}\Starter\inst\inst-Firebird\fb64\{#FBInst}"; Description: "Firebird"; Parameters: "/PASSWORD=masterkey /SERVER=SuperServer /SILENT /SP- /COMPONENTS=SuperServerComponent,ClassicServerComponent,ServerComponent,DevAdminComponent,ClientComponent"; Flags: runascurrentuser


;Filename: "{commonpf64}\Firebird\Firebird_4_0\gsec.exe"; Description: "gsec"; Parameters: "-user sysdba -password masterkey -create -DBA -pw masterkey"; Flags: runascurrentuser
;Filename: "{commonpf64}\Firebird\Firebird_4_0\gsec.exe";                      Parameters: "-user sysdba -password masterkey -modify sysdba -pw masterkey"; Flags: runascurrentuser; Description: "Configurando Firebird"

;exclusion
Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; Description: "PowerShell"; Parameters: "-ExecutionPolicy Bypass -Command ""Add-MpPreference -ExclusionPath '{app}'"""; Flags: runascurrentuser runhidden 

;compartilha 
Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; Description: "PowerShell"; Parameters: "-ExecutionPolicy Bypass -Command ""New-SmbShare -Name 'DarosPDV' -Path 'C:\DarosPDV' -FullAccess 'Everyone'"""; Flags: runascurrentuser runhidden

;starter
Filename: "{app}\Starter\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\Starter\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\Starter\{#MyAppExeName}"; Tasks: desktopicon
Name: "{autodesktop}\LogProcess202311"; Filename: "{app}\Tmp\LogProcess\2023\11\02"; WorkingDir: "{app}\Tmp\Log\2023\11\02"
Name: "{autodesktop}\ISQL"; Filename: "{commonpf64}\Firebird\Firebird_4_0\isql.exe"; Parameters: "BTUSERVIDOR:{app}\dados\retag.fdb"



