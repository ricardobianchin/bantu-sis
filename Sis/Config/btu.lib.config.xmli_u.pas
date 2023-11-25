unit btu.lib.config.xmli_u;

interface

uses btu.lib.config.xmli, btu.lib.config;

type
  TConfigXMLI = class(TInterfacedObject, IConfigXMLI)
  private
    FSisConfig: ISisConfig;
  public
    procedure Gravar;
    procedure Ler;
    constructor Create(pSisConfig: ISisConfig);
  end;

implementation

uses Xml.XMLDoc, Xml.XMLIntf, System.SysUtils, sis.types.bool.utils,
  {System.Win.ComObj} WinApi.ActiveX, btu.lib.db.types, sis.types.floats,
  sis.win.VersionInfo, sis.sis.constants, System.TypInfo,
  sis.win.VersionInfo_u;

{ TConfigXMLI }

constructor TConfigXMLI.Create(pSisConfig: ISisConfig);
begin
  FSisConfig := pSisConfig;
end;

procedure TConfigXMLI.Gravar;
var
  XMLDoc: IXMLDOCUMENT;
  ConfigNode, ServerNode, ServerNomeNode, ServerIpNode, IsServerNode, LocalNode,
    LocalNomeNode, LocalIpNode, DBMSNode, SoftwareNode, VersaoDBMSNode,
    DBFrameworNode, WinNode, VersaoSONode, CSDVersionNode, WinPlatformNode

    : IXMLNODE;
  s: string;
begin
  CoInitialize(nil);

  try
    XMLDoc := NewXMLDocument;
    XMLDoc.Options := [doNodeAutoIndent];
    XMLDoc.Encoding := 'utf-8';

    ConfigNode := XMLDoc.AddChild('CONFIG');

    ServerNode := ConfigNode.AddChild('SERVER');
    begin
      ServerNomeNode := ServerNode.AddChild('NOME');
      ServerNomeNode.Text := FSisConfig.ServerMachineId.Name;

      ServerIpNode := ServerNode.AddChild('IP');
      ServerIpNode.Text := FSisConfig.ServerMachineId.IP;

      IsServerNode := ServerNode.AddChild('EH_SERVIDOR');
      s := BooleanToStr(FSisConfig.LocalMachineIsServer);
      IsServerNode.Text := s;
    end;

    LocalNode := ConfigNode.AddChild('LOCAL');
    begin
      LocalNomeNode := LocalNode.AddChild('NOME');
      LocalNomeNode.Text := FSisConfig.LocalMachineId.Name;

      LocalIpNode := LocalNode.AddChild('IP');
      LocalIpNode.Text := FSisConfig.LocalMachineId.IP;
    end;

    DBMSNode := ConfigNode.AddChild('DBMS');
    begin
      SoftwareNode := DBMSNode.AddChild('SOFTWARE');
      SoftwareNode.Text := DBMSNames[FSisConfig.DBMSInfo.DatabaseType];

      VersaoDBMSNode := DBMSNode.AddChild('VERSAO');
      VersaoDBMSNode.Text := FloatToStrPonto(FSisConfig.DBMSInfo.Version);

      DBFrameworNode := DBMSNode.AddChild('FRAMEWORK');
      DBFrameworNode.Text := DBFrameworkNames[FSisConfig.DBMSInfo.DBFramework];
    end;

    WinNode := ConfigNode.AddChild('SO');
    begin
      VersaoSONode := WinNode.AddChild('VERSAO');
      VersaoSONode.Text := FloatToStrPonto(FSisConfig.WinVersionInfo.Version);

      CSDVersionNode := WinNode.AddChild('CSD_VERSION');
      CSDVersionNode.Text := FSisConfig.WinVersionInfo.CSDVersion;

      WinPlatformNode := WinNode.AddChild('PLATFORM');
      WinPlatformNode.Text := WinPlatforms
        [FSisConfig.WinVersionInfo.WinPlatform];

    end;
    XMLDoc.SaveToFile(CONFIG_NOME_ARQ);
  finally
    CoUninitialize;
  end;
end;

procedure TConfigXMLI.Ler;
var
  XMLDoc: IXMLDOCUMENT;
  ConfigNode, ServerNode, ServerNomeNode, ServerIpNode, IsServerNode, LocalNode,
    LocalNomeNode, LocalIpNode, DBMSNode, SoftwareNode, VersaoDBMSNode,
    DBFrameworNode, WinNode, VersaoSONode, CSDVersionNode, WinPlatformNode

    : IXMLNODE;
  s: string;
begin
  CoInitialize(nil);

  try
    XMLDoc := LoadXMLDocument(CONFIG_NOME_ARQ);
    ConfigNode := XMLDoc.ChildNodes.FindNode('CONFIG');

    ServerNode := ConfigNode.ChildNodes.FindNode('SERVER');
    begin
      ServerNomeNode := ServerNode.ChildNodes.FindNode('NOME');
      FSisConfig.ServerMachineId.Name := ServerNomeNode.Text;

      ServerIpNode := ServerNode.ChildNodes.FindNode('IP');
      FSisConfig.ServerMachineId.IP := ServerIpNode.Text;

      IsServerNode := ServerNode.ChildNodes.FindNode('EH_SERVIDOR');
      s := IsServerNode.Text;
      FSisConfig.LocalMachineIsServer := StrToBool(s);
    end;

    LocalNode := ConfigNode.ChildNodes.FindNode('LOCAL');
    begin
      LocalNomeNode := LocalNode.ChildNodes.FindNode('NOME');
      FSisConfig.LocalMachineId.Name := LocalNomeNode.Text;

      LocalIpNode := LocalNode.ChildNodes.FindNode('IP');
      FSisConfig.LocalMachineId.IP := LocalIpNode.Text;
    end;

    DBMSNode := ConfigNode.ChildNodes.FindNode('DBMS');
    begin
      SoftwareNode := DBMSNode.ChildNodes.FindNode('SOFTWARE');
      FSisConfig.DBMSInfo.DatabaseType := StrToDBMSType(SoftwareNode.Text);

      VersaoDBMSNode := DBMSNode.ChildNodes.FindNode('VERSAO');
      FSisConfig.DBMSInfo.Version := StrToNum(VersaoDBMSNode.Text);

      DBFrameworNode := DBMSNode.ChildNodes.FindNode('FRAMEWORK');
      FSisConfig.DBMSInfo.DBFramework := StrToDBFramework(DBFrameworNode.Text);
    end;

    WinNode := ConfigNode.ChildNodes.FindNode('SO');
    begin
      VersaoSONode := WinNode.ChildNodes.FindNode('VERSAO');
      FSisConfig.WinVersionInfo.Version := StrToNum(VersaoSONode.Text);

      CSDVersionNode := WinNode.ChildNodes.FindNode('CSD_VERSION');
      FSisConfig.WinVersionInfo.CSDVersion := CSDVersionNode.Text;

      WinPlatformNode := WinNode.ChildNodes.FindNode('PLATFORM');
      FSisConfig.WinVersionInfo.WinPlatform := StrToWinPlatform(DBFrameworNode.Text);
    end;
  finally
    CoUninitialize;
  end;
end;

end.
