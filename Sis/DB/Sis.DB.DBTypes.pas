unit Sis.DB.DBTypes;

interface

uses
  FireDAC.Stan.Param, System.Classes, Data.DB, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, Sis.Sis.Nomeavel, Sis.Config.ConfigXMLI, Sis.Entities.Types;

type
  TIdLojaTermRecord = record
    LojaId: TLojaId;
    TerminalId: TTerminalId;
    Id: integer;
    procedure Zerar;
    procedure PegarCods(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pId: integer);
  end;

  TProcDataSetRef = reference to procedure(q: TDataSet);
  TProcDataSetOfObject = procedure(q: TDataSet; pRecNo: integer) of object;

  TDBVersion = double;

  TDBMSType = (dbmstUnknown, dbmstFirebird, dbmstMySQL, dbmstPostgreSQL,
    dbmstOracle, dbmstSQLServer, dbmstSQLite);

  TDBFramework = (dbfrNaoIndicado, dbfrFireDAC { , dbfrDBX, dbfrZeos } );

  TDBConnectionParams = record
    Server, Arq, Database: string;
    function GetNomeBanco: string;
  end;

  TFirebirdVersion = TDBVersion;

procedure SetParamDateTime(pFDParam: TFDParam; pDt: TDateTime);
procedure SetParamCurrency(pFDParam: TFDParam; pCurr: Currency);
procedure SetParamValue(pFDParam: TFDParam; pValor: string);

const
  DBFrameworkNames: array [TDBFramework] of string = ('NAOINDICADO', 'FIREDAC');

  DBMSNames: array [TDBMSType] of string = ('NAOINDICADO', 'FIREBIRD', 'MYSQL',
    'POSTGRESQL', 'ORACLE', 'SQLSERVER', 'SQLITE');

  ID_INT_INVALIDA: integer = 0;
  ID_CHAR_INVALIDA: Char = #32;

type
  IDBMSConfig = interface(IConfigXMLI)
    ['{5A1A706A-6F4C-43B8-9F12-D815CC4B23D0}']
    function GetPausaAntesExec: boolean;
    procedure SetPausaAntesExec(Value: boolean);
    property PausaAntesExec: boolean read GetPausaAntesExec
      write SetPausaAntesExec;
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
    // function LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB): TDBConnectionParams;
    // function LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
    // function LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
    // function LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;

    function GarantirDBMSInstalado(pProcessLog: IProcessLog;
      pOutput: IOutput): boolean;
    // function GarantirDBServCriadoEAtualizado(pProcessLog: IProcessLog;
    // pOutput: IOutput): boolean;

    // procedure ExecInterative(pNomeArqSQL: string; pLocalDoDB: TLocalDoDB; pProcessLog: IProcessLog; pOutput: IOutput); overload;
    procedure ExecInterative(pAssunto: string; pSql: string; pNomeBanco: string;
      pPastaComandos: string; pProcessLog: IProcessLog; pOutput: IOutput;
      pJanelaVisivel: boolean = False); overload;

    function GetVendorHome: string;
    property VendorHome: string read GetVendorHome;

    function GetVendorLib: string;
    property VendorLib: string read GetVendorLib;

    procedure DoBackupNow(pDtHBackup: TDateTime; pDatabasesSL: TStrings;
      pPastaComandos, pPastaBackup: string; pArqsCriadosSL: TStrings);
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
    function GetValueString(pSql: string): string;
    function GetValueInteger(pSql: string): integer;
    function GetValueInteger64(pSql: string): Int64;
    function GetValueDateTime(pSql: string): TDateTime;
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

    function GetSql: TStrings;
    property Sql: TStrings read GetSql;

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

    function GetFields: TFields;
    property Fields: TFields read GetFields;
  end;

  IDBExec = interface(IDBSqlOperation)
    ['{97F1A38D-F2DD-4B0F-9CFE-7AE9F50232EC}']
    procedure Execute;
  end;

  IDBExecScript = interface(IDBSqlOperation)
    ['{4548FEFF-5026-4E84-B0DC-E31D7EFD28FC}']
    procedure Execute;
    procedure PegueComando(pComando: string);
  end;

function StrToDBFramework(pStr: string): TDBFramework;
function StrToDBMSType(pStr: string): TDBMSType;

implementation

uses System.SysUtils, Data.SqlTimSt, Sis.Types.Bool_u, Sis.Types.Floats;

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

procedure SetParamDateTime(pFDParam: TFDParam; pDt: TDateTime);
begin
  if pDt = 0 then
  begin
    pFDParam.Clear;
    exit;
  end;

  case pFDParam.DataType of
    ftTimeStamp:
      pFDParam.AsSQLTimeStamp := DateTimeToSQLTimeStamp(pDt);
    ftDate:
      pFDParam.AsDate := Trunc(pDt);
    ftTime:
      pFDParam.AsTime := Frac(pDt);
    ftDateTime:
      pFDParam.AsDateTIme := pDt;
  else // ftTimeStampOffset:
    pFDParam.Value := pDt;
  end;
end;

procedure SetParamCurrency(pFDParam: TFDParam; pCurr: Currency);
begin
  case pFDParam.DataType of
    ftUnknown:
      ;
    ftString:
      ;
    ftSmallint:
      ;
    ftInteger:
      ;
    ftWord:
      ;
    ftBoolean:
      ;
    ftFloat:
      pFDParam.AsFloat := pCurr;
    ftCurrency:
      pFDParam.AsCurrency := pCurr;
    ftBCD:
      pFDParam.AsBCD := pCurr;
    ftDate:
      ;
    ftTime:
      ;
    ftDateTime:
      ;
    ftBytes:
      ;
    ftVarBytes:
      ;
    ftAutoInc:
      ;
    ftBlob:
      ;
    ftMemo:
      ;
    ftGraphic:
      ;
    ftFmtMemo:
      ;
    ftParadoxOle:
      ;
    ftDBaseOle:
      ;
    ftTypedBinary:
      ;
    ftCursor:
      ;
    ftFixedChar:
      ;
    ftWideString:
      ;
    ftLargeint:
      ;
    ftADT:
      ;
    ftArray:
      ;
    ftReference:
      ;
    ftDataSet:
      ;
    ftOraBlob:
      ;
    ftOraClob:
      ;
    ftVariant:
      ;
    ftInterface:
      ;
    ftIDispatch:
      ;
    ftGuid:
      ;
    ftTimeStamp:
      ;
    ftFMTBcd:
      pFDParam.AsFMTBCD := pCurr;
    ftFixedWideChar:
      ;
    ftWideMemo:
      ;
    ftOraTimeStamp:
      ;
    ftOraInterval:
      ;
    ftLongWord:
      ;
    ftShortint:
      ;
    ftByte:
      ;
    ftExtended:
      pFDParam.AsExtended := pCurr;
    ftConnection:
      ;
    ftParams:
      ;
    ftStream:
      ;
    ftTimeStampOffset:
      ;
    ftObject:
      ;
    ftSingle:
      pFDParam.AsSingle := pCurr;
  end;
end;

procedure SetParamValue(pFDParam: TFDParam; pValor: string);
begin
  if pValor = 'NULL' then
  begin
    pFDParam.Clear;
    exit;
  end;

  case pFDParam.DataType of
    ftUnknown:
      ;
    ftWideString, ftString, ftFixedChar:
      pFDParam.AsString := pValor;

    ftSmallint:
      pFDParam.AsSmallInt := StrToInt(pValor);
    ftInteger:
      pFDParam.AsInteger := StrToInt(pValor);
    ftLargeint:
      pFDParam.AsLargeInt := StrToInt64(pValor);

    ftWord:
      pFDParam.AsInteger := StrToInt(pValor);
    ftBoolean:
      pFDParam.AsBoolean := StrToBoolean(pValor);

    ftFloat:
      pFDParam.AsFloat := StrToFloat(pValor);
    ftCurrency:
      pFDParam.AsCurrency := StrToCurrency(pValor);
    ftBCD:
      pFDParam.AsBCD := StrToCurrency(pValor);
    ftSingle:
      pFDParam.AsSingle := StrToFloat(pValor);
    ftFMTBcd:
      pFDParam.AsFMTBCD := StrToCurrency(pValor); // problema aqui

    ftTimeStamp:
      pFDParam.AsSQLTimeStamp := StrToSQLTimeStamp(pValor);
    ftDate:
      pFDParam.AsDate := Trunc(StrToDate(pValor));
    ftTime:
      pFDParam.AsTime := Frac(StrToTime(pValor));
    ftDateTime:
      pFDParam.AsDateTIme := StrToDateTime(pValor);
    (*
      ftBytes:
      ;
      ftVarBytes:
      ;
      ftAutoInc:
      ;
      ftBlob:
      ;
      ftMemo:
      ;
      ftGraphic:
      ;
      ftFmtMemo:
      ;
      ftParadoxOle:
      ;
      ftDBaseOle:
      ;
      ftTypedBinary:
      ;
      ftCursor:
      ;
      ftADT:
      ;
      ftArray:
      ;
      ftReference:
      ;
      ftDataSet:
      ;
      ftOraBlob:
      ;
      ftOraClob:
      ;
      ftVariant:
      ;
      ftInterface:
      ;
      ftIDispatch:
      ;
      ftGuid:
      ;
      ftFMTBcd:
      ;
      ftFixedWideChar:
      ;
      ftWideMemo:
      ;
      ftOraTimeStamp:
      ;
      ftOraInterval:
      ;
      ftLongWord:
      ;
      ftShortint:
      ;
      ftByte:
      ;
      ftExtended:
      ;
      ftConnection:
      ;
      ftParams:
      ;
      ftStream:
      ;
      ftTimeStampOffset:
      ;
      ftObject:
      ;
    *)
  else
    raise Exception.Create('SetParamValue: Tipo nao programado. Campo ' +
      pFDParam.Name + ' tipo:' + FieldTypeNames[pFDParam.DataType]);
  end;

  (*



    ftString, ftFixedChar:
    begin
    Result := QuotedStr(pField.AsString);
    end;

    ftSmallint, ftInteger, ftWord, ftWideString, ftLargeint, ftAutoInc,
    ftShortint, ftByte:
    begin
    Result := pField.AsString;
    end;

    ftBoolean:
    begin
    Result := Iif(pField.AsBoolean, 'TRUE', 'FALSE');
    end;

    ftFloat:
    begin
    Result := pField.AsFloat.ToString;
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
    end;

    ftCurrency:
    begin
    Result := CurrencyToStrPonto(pField.AsCurrency);
    //        Result := Format('%0.4f', [pField.AsCurrency]);
    // Result := pField.AsCurrency.ToString;
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
    end;

    ftFMTBcd:
    begin
    Result := CurrencyToStrPonto(pField.AsCurrency);
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
    end;

    ftBCD:
    begin
    Result := CurrencyToStrPonto(pField.AsCurrency);
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
    end;

    ftSingle:
    begin
    Result := pField.AsSingle.ToString;
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
    end;

    ftExtended:
    begin
    Result := pField.AsExtended.ToString;
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
    end;

    ftDate:
    begin
    Result := DataSQLFirebird(pField.AsDateTime)
    end;

    ftTime:
    begin
    Result := HoraSQLFirebird(pField.AsDateTime);
    end;

    ftDateTime, ftTimeStamp:
    begin
    Result := DataHoraSQLFirebird(pField.AsDateTime);
    end;


    {
    ftUnknown: ;
    ftBytes: ;
    ftVarBytes: ;
    ftBlob: ;
    ftMemo: ;
    ftGraphic: ;
    ftFmtMemo: ;
    ftParadoxOle: ;
    ftDBaseOle: ;
    ftTypedBinary: ;
    ftCursor: ;
    ftADT: ;
    ftArray: ;
    ftReference: ;
    ftDataSet: ;
    ftOraBlob: ;
    ftOraClob: ;
    ftVariant: ;
    ftInterface: ;
    ftIDispatch: ;
    ftGuid: ;
    ftFMTBcd: ;
    ftFixedWideChar: ;
    ftWideMemo: ;
    ftOraTimeStamp: ;
    ftOraInterval: ;
    ftLongWord: ;
    ftConnection: ;
    ftParams: ;
    ftStream: ;
    ftTimeStampOffset: ;
    ftObject: ;
    }
  *)
end;

{ TIdLojaTermRecord }

procedure TIdLojaTermRecord.PegarCods(pLojaId: TLojaId;
  pTerminalId: TTerminalId; pId: integer);
begin
  LojaId := pLojaId;
  TerminalId := pTerminalId;
  Id := pId;
end;

procedure TIdLojaTermRecord.Zerar;
begin
  LojaId := 0;
  TerminalId := 0;
  Id := 0;
end;

end.
