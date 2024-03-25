unit Sis.Config.SisConfig.XMLI_u;

interface

uses Sis.Config.SisConfig, Sis.Config.SisConfig.XMLI, Sis.Config.ConfigXMLI_u,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TSisConfigXMLI = class(TConfigXMLI, ISisConfigXMLI)
  private
    FSisConfig: ISisConfig;
  protected
    function PrepLer: boolean; override;
    function PrepGravar: boolean; override;
  public
    constructor Create(pSisConfig: ISisConfig; pProcessLog: IProcessLog = nil;
      pOutput: IOutput = nil);
  end;

implementation

uses Xml.XMLDoc, Xml.XMLIntf, System.SysUtils, {System.Win.ComObj}
  System.TypInfo, Sis.Types.Bool_u, Sis.DB.DBTypes,
  Sis.Types.Floats, Sis.Win.VersionInfo, Sis.Win.Utils_u, Sis.Sis.Constants;

{ TSisConfigXMLI }

constructor TSisConfigXMLI.Create(pSisConfig: ISisConfig;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create('CONFIG', CONFIG_ARQ_NOME, CONFIG_ARQ_EXT, '', False,
    pProcessLog, pOutput);
  FSisConfig := pSisConfig;
end;

function TSisConfigXMLI.PrepGravar: boolean;
var
  ServerNode, ServerNomeNode, ServerIpNode, IsServerNode, LocalNode,
    LocalNomeNode, LocalIpNode, DBMSNode, SoftwareNode, VersaoDBMSNode,
    DBFrameworNode, WinNode, VersaoSONode, CSDVersionNode, WinPlatformNode

    : IXMLNODE;
  s: string;
begin
  Result := Inherited;
  if not Result then
    exit;

  ServerNode := RootNode.AddChild('SERVER');
  begin
    ServerNomeNode := ServerNode.AddChild('NOME');
    ServerNomeNode.Text := FSisConfig.ServerMachineId.Name;

    ServerIpNode := ServerNode.AddChild('IP');
    ServerIpNode.Text := FSisConfig.ServerMachineId.IP;

    IsServerNode := ServerNode.AddChild('EH_SERVIDOR');
    s := BooleanToStr(FSisConfig.LocalMachineIsServer);
    IsServerNode.Text := s;
  end;

  LocalNode := RootNode.AddChild('LOCAL');
  begin
    LocalNomeNode := LocalNode.AddChild('NOME');
    LocalNomeNode.Text := FSisConfig.LocalMachineId.Name;

    LocalIpNode := LocalNode.AddChild('IP');
    LocalIpNode.Text := FSisConfig.LocalMachineId.IP;
  end;

  DBMSNode := RootNode.AddChild('DBMS');
  begin
    SoftwareNode := DBMSNode.AddChild('SOFTWARE');
    SoftwareNode.Text := DBMSNames[FSisConfig.DBMSInfo.DatabaseType];

    VersaoDBMSNode := DBMSNode.AddChild('VERSAO');
    VersaoDBMSNode.Text := FloatToStrPonto(FSisConfig.DBMSInfo.Version);

    DBFrameworNode := DBMSNode.AddChild('FRAMEWORK');
    DBFrameworNode.Text := DBFrameworkNames[FSisConfig.DBMSInfo.DBFramework];
  end;

  WinNode := RootNode.AddChild('SO');
  begin
    VersaoSONode := WinNode.AddChild('VERSAO');
    VersaoSONode.Text := FloatToStrPonto(FSisConfig.WinVersionInfo.Version);

    CSDVersionNode := WinNode.AddChild('CSD_VERSION');
    CSDVersionNode.Text := FSisConfig.WinVersionInfo.CSDVersion;

    WinPlatformNode := WinNode.AddChild('PLATFORM');
    WinPlatformNode.Text := WinPlatforms[FSisConfig.WinVersionInfo.WinPlatform];
  end;
end;

function TSisConfigXMLI.PrepLer: boolean;
var
  ServerNode, ServerNomeNode, ServerIpNode, IsServerNode, LocalNode,
    LocalNomeNode, LocalIpNode, DBMSNode, SoftwareNode, VersaoDBMSNode,
    DBFrameworNode, WinNode, VersaoSONode, CSDVersionNode, WinPlatformNode

    : IXMLNODE;
  s: string;
begin
  Result := Inherited;
  if not Result then
    exit;

  ServerNode := RootNode.ChildNodes.FindNode('SERVER');
  begin
    ServerNomeNode := ServerNode.ChildNodes.FindNode('NOME');
    FSisConfig.ServerMachineId.Name := ServerNomeNode.Text;

    ServerIpNode := ServerNode.ChildNodes.FindNode('IP');
    FSisConfig.ServerMachineId.IP := ServerIpNode.Text;

    IsServerNode := ServerNode.ChildNodes.FindNode('EH_SERVIDOR');
    s := IsServerNode.Text;
    FSisConfig.LocalMachineIsServer := StrToBool(s);
  end;

  LocalNode := RootNode.ChildNodes.FindNode('LOCAL');
  begin
    LocalNomeNode := LocalNode.ChildNodes.FindNode('NOME');
    FSisConfig.LocalMachineId.Name := LocalNomeNode.Text;

    LocalIpNode := LocalNode.ChildNodes.FindNode('IP');
    FSisConfig.LocalMachineId.IP := LocalIpNode.Text;
  end;

  DBMSNode := RootNode.ChildNodes.FindNode('DBMS');
  begin
    SoftwareNode := DBMSNode.ChildNodes.FindNode('SOFTWARE');
    FSisConfig.DBMSInfo.DatabaseType := StrToDBMSType(SoftwareNode.Text);

    VersaoDBMSNode := DBMSNode.ChildNodes.FindNode('VERSAO');
    FSisConfig.DBMSInfo.Version := StrToNum(VersaoDBMSNode.Text);

    DBFrameworNode := DBMSNode.ChildNodes.FindNode('FRAMEWORK');
    FSisConfig.DBMSInfo.DBFramework := StrToDBFramework(DBFrameworNode.Text);
  end;

  WinNode := RootNode.ChildNodes.FindNode('SO');
  begin
    VersaoSONode := WinNode.ChildNodes.FindNode('VERSAO');
    FSisConfig.WinVersionInfo.Version := StrToNum(VersaoSONode.Text);

    CSDVersionNode := WinNode.ChildNodes.FindNode('CSD_VERSION');
    FSisConfig.WinVersionInfo.CSDVersion := CSDVersionNode.Text;

    WinPlatformNode := WinNode.ChildNodes.FindNode('PLATFORM');
    FSisConfig.WinVersionInfo.WinPlatform :=
      StrToWinPlatform(DBFrameworNode.Text);
  end;
end;

end.
