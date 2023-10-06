unit btu.sta.exec_xml_u;

interface

uses
  btu.lib.config;

procedure ConfigXmlCreate(pSisConfig: ISisConfig);
procedure ConfigXmlCarregue(pSisConfig: ISisConfig);

implementation

uses btu.lib.sis.constants, ActiveX, XMLIntf, XMLDoc;

procedure ConfigXmlCreate(pSisConfig: ISisConfig);
var
  XmlDoc: IXMLDOCUMENT;
  ConfigNode
    , ServerNode
      , ServerNomeNode
      , ServerIpNode
    : IXMLNODE;
begin
  exit;
  CoInitialize(nil);
  try
    XMLDoc := NewXMLDocument;
    XMLDoc.Options := [doNodeAutoIndent];
    XMLDoc.Encoding := 'utf-8';

    ConfigNode := XMLdOC.AddChild('CONFIG');
    ServerNode := ConfigNode.AddChild('SERVER');

    ServerNomeNode := ServerNode.AddChild('NOME');
    ServerNomeNode.Text := pSisConfig.ServerMachineId.Name;

    ServerIpNode := ServerNode.AddChild('IP');
    ServerIpNode.Text := pSisConfig.ServerMachineId.Name;

    XmlDoc.SaveToFile(CONFIG_NOME_ARQ);
  finally
    CoUninitialize;
  end;
end;
{

    function GetLocalMachineId: IMachineId;
    property LocalMachineId: IMachineId read GetLocalMachineId;

    function GetLocalMachineIsServer: boolean;
    procedure SetLocalMachineIsServer(const Value: boolean);
    property LocalMachineIsServer: boolean read GetLocalMachineIsServer write SetLocalMachineIsServer;

    function GetServerMachineId: IMachineId;
    property ServerMachineId: IMachineId read GetServerMachineId;

    function GetWinVersionInfo: IWinVersionInfo;
    property WinVersionInfo: IWinVersionInfo read GetWinVersionInfo;



  FSisConfig := SisConfigCreate;

    FSisConfig := SisConfigCreate;
  FUsuLogin := UsuLoginCreate;
  FLoja := btu.lib.entit.factory.LojaCreate;

 }

procedure ConfigXmlCarregue(pSisConfig: ISisConfig);
begin

end;

end.
