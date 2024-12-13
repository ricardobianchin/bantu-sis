unit Configs_u;

interface

uses System.Generics.Collections, FireDAC.Stan.Intf, FireDAC.Phys.FB,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  FireDAC.Stan.Async, FireDAC.Comp.UI, DBServDM_u, DBTermDM_u, Sis_u, DB_u;

type
  TServer = record
    Nome: string;
    IP: string;
    EhServidor: string;
  end;

  TLocal = record
    Nome: string;
    IP: string;
  end;

  TDBMS = record
    Software: string;
    Versao: string;
    Framework: string;
  end;

  TSO = record
    Versao: string;
    CSDVersion: string;
    Platform: string;
  end;

  TConfig = record
    Server: TServer;
    Local: TLocal;
    DBMS: TDBMS;
    SO: TSO;
  end;

var
  Config: TConfig;

procedure CarregarConfigs;
function DBServDMCreate: TDBServDM;

implementation

uses System.SysUtils, Sis.UI.IO.Files, Xml.XMLIntf, Xml.XMLDoc, Log_u;

function LoadConfigFromXML(const FileName: string): TConfig;
var
  XMLDoc: IXMLDocument;
  RootNode, Node: IXMLNode;
begin
  XMLDoc := LoadXMLDocument(FileName);

  RootNode := XMLDoc.DocumentElement;

  Node := RootNode.ChildNodes['SERVER'];
  Result.Server.Nome := Node.ChildNodes['NOME'].Text;
  Result.Server.IP := Node.ChildNodes['IP'].Text;
  Result.Server.EhServidor := Node.ChildNodes['EH_SERVIDOR'].Text;

  Node := RootNode.ChildNodes['LOCAL'];
  Result.Local.Nome := Node.ChildNodes['NOME'].Text;
  Result.Local.IP := Node.ChildNodes['IP'].Text;

  Node := RootNode.ChildNodes['DBMS'];
  Result.DBMS.Software := Node.ChildNodes['SOFTWARE'].Text;
  Result.DBMS.Versao := Node.ChildNodes['VERSAO'].Text;
  Result.DBMS.Framework := Node.ChildNodes['FRAMEWORK'].Text;

  Node := RootNode.ChildNodes['SO'];
  Result.SO.Versao := Node.ChildNodes['VERSAO'].Text;
  Result.SO.CSDVersion := Node.ChildNodes['CSD_VERSION'].Text;
  Result.SO.Platform := Node.ChildNodes['PLATFORM'].Text;
end;

function DBServDMCreate: TDBServDM;
var
  sDriver: string;
  sServer: string;
  sArq: string;
begin
  EscrevaLog('DBServDMCreate');
  Result := TDBServDM.Create(nil);

  Result.Connection.LoginPrompt := false;
  sDriver := 'FB';
  sServer := IdentStr(Config.Server.Nome, Config.Server.IP);
  sArq := sPastaDados + 'dados_mercado_retaguarda.fdb';

  Result.Connection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + sServer + #13#10 //
    + 'Database=' + sArq + #13#10 //
    + 'Password=masterkey'#13#10 //
    + 'User_Name=sysdba'#13#10 //
    + 'Protocol=TCPIP' //
    ;
end;

procedure CarregarConfigs;
var
  sPastaConfigs: string;
  sNomeXml: string;
begin
  sPastaBin := IncludeTrailingPathDelimiter(GetCurrentDir);
  sPastaProduto := PastaAcima(sPastaBin);
  sPastaDados := sPastaProduto + 'Dados\';
  sPastaTmp := sPastaProduto + 'Tmp\';

  sPastaConfigs := sPastaProduto + 'Configs\';
  sNomeXml := sPastaConfigs + 'Sis.Config.SisConfig.xml';
  Config := LoadConfigFromXML(sNomeXml);

  InicializePrecisaTerminar;
end;

end.
