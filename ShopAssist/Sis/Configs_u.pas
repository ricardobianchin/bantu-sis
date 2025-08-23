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
  out pLocalNomeNaRede: string; out pLocalIp: string;
  out pLocalArqDados: string);

implementation

uses System.SysUtils, Sis.UI.IO.Files, Xml.XMLIntf, Xml.XMLDoc, IniFiles,
  Sis.Win.Utils_u, Sis.Log, Sis.Log_u, Sis.Types.Bool_u;

function LoadConfigFromXML(const FileName: string; var sLog: string): TConfig;
var
  XMLDoc: IXMLDocument;
  RootNode, Node: IXMLNode;
  sServNomeNaRede, sServIp: string;
  sLocalNomeNaRede, sLocalIp: string;
  sLocalArqDados: string;
begin
  sLog := sLog + ';LoadConfigFromXML: ' + FileName + ';';
  XMLDoc := LoadXMLDocument(FileName);

  RootNode := XMLDoc.DocumentElement;
  sLog := sLog + 'RootNode: ' + RootNode.NodeName + ';';

  Node := RootNode.ChildNodes['SERVER'];
  Result.Server.Nome := Node.ChildNodes['NOME'].Text;
  Result.Server.IP := Node.ChildNodes['IP'].Text;
  Result.Server.EhServidor := Node.ChildNodes['EH_SERVIDOR'].Text;

  sLog := sLog + 'Server: ' + Result.Server.Nome + ', ' + Result.Server.IP +
    ', ' + Result.Server.EhServidor + ';';

  Result.EstSaldo.Processa := Result.Server.EhServidor;
  sLog := sLog + 'EstSaldo.Processa: ' + Result.EstSaldo.Processa + ';';

  Node := RootNode.ChildNodes['LOCAL'];
  Result.Local.Nome := Node.ChildNodes['NOME'].Text;
  Result.Local.IP := Node.ChildNodes['IP'].Text;

  sLog := sLog + 'Local: ' + Result.Local.Nome + ', ' + Result.Local.IP + ';';

  Node := RootNode.ChildNodes['DBMS'];
  Result.DBMS.Software := Node.ChildNodes['SOFTWARE'].Text;
  Result.DBMS.Versao := Node.ChildNodes['VERSAO'].Text;
  Result.DBMS.Framework := Node.ChildNodes['FRAMEWORK'].Text;

  sLog := sLog + 'DBMS: ' + Result.DBMS.Software + ', ' + Result.DBMS.Versao +
    ', ' + Result.DBMS.Framework + ';';

  Node := RootNode.ChildNodes['SO'];
  Result.SO.Versao := Node.ChildNodes['VERSAO'].Text;
  Result.SO.CSDVersion := Node.ChildNodes['CSD_VERSION'].Text;
  Result.SO.Platform := Node.ChildNodes['PLATFORM'].Text;

  sLog := sLog + 'SO: ' + Result.SO.Versao + ', ' + Result.SO.CSDVersion + ', '
    + Result.SO.Platform + ';';

  // CarregarIni_MaqLocal(sServNomeNaRede, sServIp, sLocalNomeNaRede, sLocalIp,
  // sLocalArqDados);
  // if sServNomeNaRede <> '' then
  // begin
  // Result.Server.Nome := sServNomeNaRede;
  // Result.Server.IP := sServIp;
  // Result.Local.Nome := sLocalNomeNaRede;
  // Result.Local.IP := sLocalIp;
  // sPastaDados := GetPastaDoArquivo(sLocalArqDados);
  // pLog := pLog + 'Server.nome = ' + Result.Server.Nome + ';' +
  // 'Server.IP = ' + Result.Server.IP + ';' + 'Local.nome = ' +
  // Result.Local.Nome + ';' + 'Local.IP = ' + Result.Local.IP + ';' +
  // 'PastaDados = ' + sPastaDados + ';';
  // exit;
  // end;
  // pLog := pLog + 'CarregarIni_MaqLocal retornou vazio' + ';' +
  // 'LoadConfigFromXML fim';
  sLog := sLog + ';LoadConfigFromXML fim';
end;

function DBServDMCreate: TDBServDM;
var
  sDriver: string;
  sServer: string;
  sArq: string;
  s: string;
begin

  Log.Escreva('DBServDMCreate');
  // EscrevaLog('DBServDMCreate');
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
  s := 'DBServDM Params'#13#10 + Result.Connection.Params.Text + #13#10;
  Log.Escreva(s);

  Log.Escreva('DBServDMCreate fim');
end;

procedure CarregarIni_Ativo;
var
  sNomeArqIni: string;
  IniFile: TIniFile;
begin
  Log.Escreva('CarregarIni_Ativo');
  sNomeArqIni := sPastaConfig + 'ShopAssist.ini';
  if not FileExists(sNomeArqIni) then
    exit;

  IniFile := TIniFile.Create(sNomeArqIni);
  try
    bAtivo := IniFile.ReadBool('exec', 'ativo', True);
    Log.Escreva('Ativo=' + BooleanToStr(bAtivo));

    bSegueAberto := IniFile.ReadBool('exec', 'segue_aberto', True);
    Log.Escreva('bSegueAberto=' + BooleanToStr(bSegueAberto));
  finally
    IniFile.Free;
    Log.Escreva('CarregarIni_Ativo fim');
  end;
end;

procedure CarregarConfigs;
var
  sPastaConfigs: string;
  sNomeXml: string;
  sLog: string;
begin
  try
    sLog := 'CarregarConfigs ini;';
    sPastaBin := IncludeTrailingPathDelimiter(GetCurrentDir);
    sPastaProduto := PastaAcima(sPastaBin);
    sPastaDados := sPastaProduto + 'Dados\';
    sPastaDadosServ := 'C:\DarosPDV\Dados\';
    sPastaConfig := sPastaProduto + 'Configs\';
    sPastaTmp := sPastaProduto + 'Tmp\';
    sPastaLog := sPastaTmp + 'Assist\';
    sPastaBackup := sPastaProduto + 'Backup\';
    sPastaComandos := sPastaProduto + 'Comandos\';
    sPastaComandosBackup := sPastaComandos + 'Backup\';
    sPastaDocs := sPastaProduto + 'Docs\';

    sLog := sLog + 'sPastaBin: ' + sPastaBin + ';' + 'sPastaProduto: ' +
      sPastaProduto + ';' + 'sPastaDados: ' + sPastaDados + ';' +
      'sPastaDadosServ: ' + sPastaDadosServ + ';' + 'sPastaConfig: ' +
      sPastaConfig + ';' + 'sPastaTmp: ' + sPastaTmp + ';' + 'sPastaBackup: ' +
      sPastaBackup + ';' + 'sPastaComandos: ' + sPastaComandos + ';' +
      'sPastaComandosBackup: ' + sPastaComandosBackup + ';' + 'sPastaDocs: ' +
      sPastaDocs;

    sPastaConfigs := sPastaProduto + 'Configs\';
    sNomeXml := sPastaConfigs + 'Sis.Config.SisConfig.xml';
    Config := LoadConfigFromXML(sNomeXml, sLog);

    InicializePrecisaTerminar(sLog);

    if not Assigned(Sis.Log.Log) then
    begin
      Sis.Log.Log := Sis.Log_u.TLog.Create;
      Sis.Log.Log.Escreva(sLog + #13#10'CarregarConfigs fim');
    end;
  except
    on e: exception do
    begin
      sLog := sLog + e.Message;
      Sis.Log.Log.Escreva(';erro: ' + sLog);
    end;
  end;
end;

procedure CarregarIni_MaqLocal(out pServNomeNaRede: string; out pServIp: string;
  out pLocalNomeNaRede: string; out pLocalIp: string;
  out pLocalArqDados: string);
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
