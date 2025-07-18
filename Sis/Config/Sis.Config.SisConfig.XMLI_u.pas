unit Sis.Config.SisConfig.XMLI_u;

interface

uses Sis.Config.SisConfig, Sis.Config.SisConfig.XMLI, Sis.Config.ConfigXMLI_u,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.TerminalList;

type
  TSisConfigXMLI = class(TConfigXMLI, ISisConfigXMLI)
  private
    FSisConfig: ISisConfig;
    FTerminalList: ITerminalList;
  protected
    function PrepLer: boolean; override;
    function PrepGravar: boolean; override;
  public
    constructor Create(pSisConfig: ISisConfig; pTerminalList: ITerminalList;
      pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

uses Xml.XMLDoc, Xml.XMLIntf, System.SysUtils, {System.Win.ComObj}
  System.TypInfo, Sis.Types.Bool_u, Sis.DB.DBTypes, Sis.Terminal,
  Sis.Types.Floats, Sis.Win.VersionInfo, Sis.Win.Utils_u, Sis.Sis.Constants,
  Sis.Terminal.Factory_u;

{ TSisConfigXMLI }

constructor TSisConfigXMLI.Create(pSisConfig: ISisConfig;
  pTerminalList: ITerminalList; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create('CONFIG', CONFIG_ARQ_NOME, CONFIG_ARQ_EXT, '', False,
    pProcessLog, pOutput);
  FSisConfig := pSisConfig;
  FTerminalList := pTerminalList;
end;

function TSisConfigXMLI.PrepGravar: boolean;
var
  i: integer;
  ServerNode, ServerNomeNode, ServerIpNode, ServerLetraDoDriveNode,
    IsServerNode, LocalNode, LocalNomeNode, LocalIpNode, LocalLetraDoDriveNode,
    ServerArqConfigNode, DBMSNode, SoftwareNode, VersaoDBMSNode, DBFrameworNode,
    WinNode, VersaoSONode, CSDVersionNode, WinPlatformNode, TerminaisNode,
    TerminalNode

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

    ServerLetraDoDriveNode := ServerNode.AddChild('LETRA_DO_DRIVE');
    ServerLetraDoDriveNode.Text := FSisConfig.ServerMachineId.LetraDoDrive;

    IsServerNode := ServerNode.AddChild('EH_SERVIDOR');
    s := BooleanToStr(FSisConfig.LocalMachineIsServer);
    IsServerNode.Text := s;

    ServerArqConfigNode := ServerNode.AddChild('ARQ_CONFIG');
    ServerArqConfigNode.Text := FSisConfig.ServerArqConfig;
  end;

  LocalNode := RootNode.AddChild('LOCAL');
  begin
    LocalNomeNode := LocalNode.AddChild('NOME');
    LocalNomeNode.Text := FSisConfig.LocalMachineId.Name;

    LocalIpNode := LocalNode.AddChild('IP');
    LocalIpNode.Text := FSisConfig.LocalMachineId.IP;

    LocalLetraDoDriveNode := LocalNode.AddChild('LETRA_DO_DRIVE');
    LocalLetraDoDriveNode.Text := FSisConfig.LocalMachineId.LetraDoDrive;
  end;

  TerminaisNode := RootNode.AddChild('TERMINAIS');
  begin
    for i := 0 to FTerminalList.Count - 1 do
    begin
      TerminalNode := TerminaisNode.AddChild('TERMINAL');
      TerminalNode.Attributes['ID'] := FTerminalList[i].TerminalId;
      TerminalNode.AddChild('NOME').Text := FTerminalList[i].NomeNaRede;
      TerminalNode.AddChild('IP').Text := FTerminalList[i].IP;
    end;
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
    LocalNomeNode, LocalIpNode, ServerArqConfigNode, DBMSNode, SoftwareNode,
    VersaoDBMSNode, DBFrameworNode, WinNode, VersaoSONode, CSDVersionNode,
    WinPlatformNode, TerminaisNode, TerminalNode

    : IXMLNODE;
  s: string;
  i: integer;
  oTerminal: ITerminal;
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

    ServerArqConfigNode := ServerNode.ChildNodes.FindNode('ARQ_CONFIG');
    FSisConfig.ServerArqConfig := ServerArqConfigNode.Text;

  end;

  LocalNode := RootNode.ChildNodes.FindNode('LOCAL');
  begin
    LocalNomeNode := LocalNode.ChildNodes.FindNode('NOME');
    FSisConfig.LocalMachineId.Name := LocalNomeNode.Text;

    LocalIpNode := LocalNode.ChildNodes.FindNode('IP');
    FSisConfig.LocalMachineId.IP := LocalIpNode.Text;
  end;

  TerminaisNode := RootNode.ChildNodes.FindNode('TERMINAIS');
  if Assigned(TerminaisNode) then
  begin
    // Count terminal nodes
    FTerminalList.Clear;

    // Read each TERMINAL node
    for i := 0 to TerminaisNode.ChildNodes.Count - 1 do
    begin
      TerminalNode := TerminaisNode.ChildNodes[i];
      oTerminal := TerminalCreate;
      FTerminalList.Add(oTerminal);
      oTerminal.TerminalId := StrToIntDef(TerminalNode.Attributes['ID'], 0);
      oTerminal.NomeNaRede := TerminalNode.ChildNodes['NOME'].Text;
      oTerminal.IP := TerminalNode.ChildNodes['IP'].Text;
    end;
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
