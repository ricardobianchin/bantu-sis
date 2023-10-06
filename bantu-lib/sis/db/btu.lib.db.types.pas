unit btu.lib.db.types;

interface

uses
  FireDAC.Stan.Param
  , System.Classes
  , Data.DB
  ;

type
  TDBVersion = double;

  TDBMSType = (
    dbmstUnknown,
    dbmstFirebird,
    dbmstMySQL,
    dbmstPostgreSQL,
    dbmstOracle,
    dbmstSQLServer,
    dbmstSQLite
  );

  TLocalDoDB = (
    ldbNaoIndicado
    , ldbServidor
    , ldbTerminal
    );

  TDBFramework = (dbfrFireDAC{, dbfrDBX, dbfrZeos});

  TDBConnectionParams = record
    Server, Arq, Database: string;
  end;

const
  DBMSNames: array[TDBMSType] of string = (
    'NaoIndicado',
    'Firebird',
    'MySQL',
    'PostgreSQL',
    'Oracle',
    'SQL Server',
    'SQLite'
  );

  TiposDeLocalDB: array[TLocalDoDB] of string = (
    'NaoIndicado'
    , 'Servidor'
    , 'Terminal'
    );

type
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

  IDBConnection = interface(IInterface)
    ['{5984CEAC-D7A0-41F5-9ED5-35627D5E5D49}']
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;

    function GetConnectionObject:TObject;
    property ConnectionObject:TObject read GetConnectionObject;

    function Abrir: boolean;
    procedure Fechar;
    function GetAberto: boolean;
    property Aberto: boolean read GetAberto;

    function GetUltimoErro: string;
    procedure SetUltimoErro(const Value: string);
    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    function GetValue(pSql: string): Variant;
    procedure QueryDataSet(pSql: string; var pDataSet: TDataSet);
  end;

  IDBSqlOperation = interface(IInterface)
    ['{16190228-4243-4196-BEAF-0B9AF16E0599}']
    function GetUltimoErro: string;
    procedure SetUltimoErro(Value: string);
    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    function GetSql: string;
    procedure SetSql(Value: string);
    property Sql: string read GetSql write SetSql;

    function GetParams:TFDParams;
    property Params:TFDParams read GetParams;

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

implementation

end.
