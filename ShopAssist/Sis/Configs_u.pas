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

  TEstSaldo = record
    Processa: string;
  end;

  TConfig = record
    Server: TServer;
    Local: TLocal;
    DBMS: TDBMS;
    SO: TSO;
    EstSaldo: TEstSaldo;
  end;

var
  Config: TConfig;

procedure CarregarConfigs;
function DBServDMCreate: TDBServDM;
procedure CarregarIni_Ativo;
procedure CarregarIni_MaqLocal(out pServNomeNaRede: string; out pServIp: string;
  out pLocalNomeNaRede: string; out pLocalIp: string; out pLocalArqDados: string);

implementation

uses System.SysUtils, Sis.UI.IO.Files, Xml.XMLIntf, Xml.XMLDoc, Log_u, IniFiles,
  Sis.Win.Utils_u;

function LoadConfigFromXML(const FileName: string): TConfig;
var
  XMLDoc: IXMLDocument;
  RootNode, Node: IXMLNode;
  sServNomeNaRede, sServIp: string;
  sLocalNomeNaRede, sLocalIp: string;
  sLocalArqDados: string;
begin
  XMLDoc := LoadXMLDocument(FileName);

  RootNode := XMLDoc.DocumentElement;

  Node := RootNode.ChildNodes['SERVER'];
  Result.Server.Nome := Node.ChildNodes['NOME'].Text;
  Result.Server.IP := Node.ChildNodes['IP'].Text;
  Result.Server.EhServidor := Node.ChildNodes['EH_SERVIDOR'].Text;

  Result.EstSaldo.Processa := Result.Server.EhServidor;

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

  CarregarIni_MaqLocal(sServNomeNaRede, sServIp, sLocalNomeNaRede, sLocalIp, sLocalArqDados);
  if sServNomeNaRede <> '' then
  begin
    Result.Server.Nome := sServNomeNaRede;
    Result.Server.IP := sServIp;
    Result.Local.Nome := sLocalNomeNaRede;
    Result.Local.IP := sLocalIp;
    sPastaDados := GetPastaDoArquivo(sLocalArqDados);
  end;
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
  sArq := sPastaDadosServ + 'dados_mercado_retaguarda.fdb';

  Result.Connection.Params.Text := //
    'DriverID=' + sDriver + #13#10 //
    + 'Server=' + sServer + #13#10 //
    + 'Database=' + sArq + #13#10 //
    + 'Password=masterkey'#13#10 //
    + 'User_Name=sysdba'#13#10 //
    + 'Protocol=TCPIP' //
    ;
end;

procedure CarregarIni_Ativo;
var
  sNomeArqIni: string;
  IniFile: TIniFile;
begin
  sNomeArqIni := sPastaConfig + 'ShopAssist.ini';
  if not FileExists(sNomeArqIni) then
    exit;

  IniFile := TIniFile.Create(sNomeArqIni);
  try
    bAtivo := IniFile.ReadBool('exec', 'ativo', True);
    bSegueAberto := IniFile.ReadBool('exec', 'segue_aberto', True);
  finally
    IniFile.Free;
  end;
end;

procedure CarregarConfigs;
var
  sPastaConfigs: string;
  sNomeXml: string;
begin
  sPastaBin := IncludeTrailingPathDelimiter(GetCurrentDir);
  sPastaProduto := PastaAcima(sPastaBin);
  sPastaDados := sPastaProduto + 'Dados\';
  sPastaDadosServ := 'C:\DarosPDV\Dados\';
  sPastaConfig := sPastaProduto + 'Configs\';
  sPastaTmp := sPastaProduto + 'Tmp\';

  sPastaConfigs := sPastaProduto + 'Configs\';
  sNomeXml := sPastaConfigs + 'Sis.Config.SisConfig.xml';
  Config := LoadConfigFromXML(sNomeXml);

  InicializePrecisaTerminar;
end;

procedure CarregarIni_MaqLocal(out pServNomeNaRede: string; out pServIp: string;
  out pLocalNomeNaRede: string; out pLocalIp: string; out pLocalArqDados: string);
var
  sNomeArqIni: string;
  IniFile: TIniFile;
begin
  sNomeArqIni := sPastaConfig + 'ShopAssist.ini';
  if not FileExists(sNomeArqIni) then
    exit;

  IniFile := TIniFile.Create(sNomeArqIni);
  try
    pServNomeNaRede := IniFile.ReadString('serv', 'nome_na_rede', '');
    pServIp := IniFile.ReadString('serv', 'ip', '');
    pLocalNomeNaRede := IniFile.ReadString('local', 'nome_na_rede', '');
    pLocalIp := IniFile.ReadString('local', 'ip', '');
    pLocalArqDados := IniFile.ReadString('local', 'arq_dados', '');
  finally
    IniFile.Free;
  end;
end;

end.
