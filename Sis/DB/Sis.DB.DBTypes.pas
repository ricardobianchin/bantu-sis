unit Sis.DB.DBTypes;

interface

uses
  FireDAC.Stan.Param, System.Classes, Data.DB, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, Sis.Sis.Nomeavel, Sis.Config;

type
  TProcDataSetRef = reference to procedure(q: TDataSet);
  TProcDataSetOfObject = procedure (q: TDataSet) of object;

  TDBVersion = double;

  TDBMSType = (dbmstUnknown, dbmstFirebird, dbmstMySQL, dbmstPostgreSQL,
    dbmstOracle, dbmstSQLServer, dbmstSQLite);

  TDBFramework = (dbfrNaoIndicado, dbfrFireDAC { , dbfrDBX, dbfrZeos } );

  TDBConnectionParams = record
    Server, Arq, Database: string;
    function GetNomeBanco: string;
  end;

  TFirebirdVersion = TDBVersion;

const
  DBFrameworkNames: array [TDBFramework] of string = ('NAOINDICADO', 'FIREDAC');

  DBMSNames: array [TDBMSType] of string = ('NAOINDICADO', 'FIREBIRD', 'MYSQL',
    'POSTGRESQL', 'ORACLE', 'SQLSERVER', 'SQLITE');

type
  IDBMSConfig = interface(IConfig)
    ['{5A1A706A-6F4C-43B8-9F12-D815CC4B23D0}']
    function GetPausaAntesExec: boolean;
    procedure SetPausaAntesExec(Value: boolean);
    property PausaAntesExec: boolean read GetPausaAntesExec write SetPausaAntesExec;
  end;

  // DBMS (Database Management System)
  IDBMSInfo = interface(IInterface)
    ['{0F87682A-7212-41F6-A917-8725F8B736DA}']
    function GetVersion: TDBVersion;
    procedure SetVersion(Value: TDBVersion);
    property Version: TDBVersion read GetVersion write SetVersion;

    function GetDBMSType: TDBMSType;
    procedure SetDBMSType(Value: TDBMSType);
    property DatabaseType: TDBMSType read GetDBMSType write SetDBMSType;

    function GetDBFramework: TDBFramework;
    procedure SetDBFramework(Value: TDBFramework);
    property DBFramework: TDBFramework read GetDBFramework write SetDBFramework;

    function GetNome: string;
    property Nome: string read GetNome;
  end;

  // DBMS (Database Management System)
  IDBMS = interface(IInterface)
    ['{538EDEC7-A17C-4F0B-80C0-F55CE89435AB}']
//    function LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB): TDBConnectionParams;
//    function LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
//    function LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
//    function LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;

    function GarantirDBMSInstalado(pProcessLog: IProcessLog; pOutput: IOutput): boolean;
//    function GarantirDBServCriadoEAtualizado(pProcessLog: IProcessLog;
//      pOutput: IOutput): boolean;

    // procedure ExecInterative(pNomeArqSQL: string; pLocalDoDB: TLocalDoDB; pProcessLog: IProcessLog; pOutput: IOutput); overload;
    procedure ExecInterative(pAssunto: string; pSql: string;
      pNomeBanco: string;
      pPastaComandos: string;
      pProcessLog: IProcessLog;
      pOutput: IOutput); overload;

    function GetVendorHome: string;
    property VendorHome: string read GetVendorHome;

    function GetVendorLib: string;
    property VendorLib: string read GetVendorLib;
  end;

  IDBConnection = interface(INomeavel)
    ['{5984CEAC-D7A0-41F5-9ED5-35627D5E5D49}']
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;

    function GetConnectionObject: TObject;
    property ConnectionObject: TObject read GetConnectionObject;

    function Abrir: boolean;
    procedure Fechar;
    function GetAberto: boolean;
    property Aberto: boolean read GetAberto;

    function GetUltimoErro: string;
    procedure SetUltimoErro(const Value: string);
    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    function GetValue(pSql: string): Variant;
    function GetValueInteger(pSql: string): integer;
    procedure QueryDataSet(pSql: string; var pDataSet: TDataSet);

    function ExecuteSQL(pSql: string): LongInt;

  end;

  IDBSqlOperation = interface(INomeavel)
    ['{16190228-4243-4196-BEAF-0B9AF16E0599}']
    function GetUltimoErro: string;
    procedure SetUltimoErro(Value: string);
    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    function GetNome: string;
    property Nome: string read GetNome;

    function GetSql: string;
    procedure SetSql(Value: string);
    property Sql: string read GetSql write SetSql;

    function GetParams: TFDParams;
    property Params: TFDParams read GetParams;

    procedure Prepare;
    procedure Unprepare;
    function GetPrepared: boolean;
    procedure SetPrepared(Value: boolean);
    property Prepared: boolean read GetPrepared write SetPrepared;

  end;

  IDBQuery = interface(IDBSqlOperation)
    ['{5316475A-293F-4C01-A4EA-E4CF114B45C6}']
    function Open: boolean;
    procedure Close;

    function GetActive: boolean;
    procedure SetActive(Value: boolean);
    property Active: boolean read GetActive write SetActive;

    function Abrir: boolean;
    procedure Fechar;

    function GetIsEmpty: boolean;
    property IsEmpty: boolean read GetIsEmpty;

    function GetDataSet: TDataSet;
    property DataSet: TDataSet read GetDataSet;
  end;

  IDBExec = interface(IDBSqlOperation)
    ['{97F1A38D-F2DD-4B0F-9CFE-7AE9F50232EC}']
    procedure Execute;
  end;

function StrToDBFramework(pStr: string): TDBFramework;
function StrToDBMSType(pStr: string): TDBMSType;

implementation

uses System.SysUtils;

function StrToDBFramework(pStr: string): TDBFramework;
begin
  if pStr = 'NAOINDICADO' then
    Result := dbfrNaoIndicado
  else
    Result := dbfrFireDAC;
end;

function StrToDBMSType(pStr: string): TDBMSType;
begin
  if pStr = 'NAOINDICADO' then
    Result := dbmstUnknown
  else if pStr = 'FIREBIRD' then
    Result := dbmstFirebird
  else if pStr = 'MYSQL' then
    Result := dbmstMySQL
  else if pStr = 'POSTGRESQL' then
    Result := dbmstPostgreSQL
  else if pStr = 'ORACLE' then
    Result := dbmstOracle
  else if pStr = 'SQLSERVER' then
    Result := dbmstSQLServer
  else // if pStr = 'SQLITE' then
    Result := dbmstSQLite;
end;

{ TDBConnectionParams }

function TDBConnectionParams.GetNomeBanco: string;
var
  sNome: string;
begin
  sNome := ChangeFileExt(ExtractFileName(Arq), '');
  Result := sNome;
end;

end.
