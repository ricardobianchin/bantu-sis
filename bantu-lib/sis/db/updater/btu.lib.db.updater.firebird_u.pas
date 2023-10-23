unit btu.lib.db.updater.firebird_u;

interface

uses
  btu.lib.db.updater_u, btu.lib.config, sis.ui.io.log, sis.ui.io.output,
  btu.lib.db.types, btu.lib.db.DBMS;

// updates especivico para firebird, no pai, funcito q diz se existe o arq dados
type
  TDBUpdaterFirebird = class(TDBUpdater)
  private
    FDatabase: string;
    FArq: string;
    FNomeBanco: string;
  protected

    // procedure AtualizeBanco;virtual; abstract;
    function GetNomeBanco: string; override;
    function GetDBExiste: boolean; override;
    procedure CrieDB; override;
//    function GetSqlDbUpdateIns: string; override;
//    function GetSqlDbUpdateGetMax: string; override;
  public
    constructor Create(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
      pSisConfig: ISisConfig; pLog: ILog; pOutput: IOutput);
  end;

implementation

uses
  btu.lib.db.firebird.utils, System.SysUtils, sis.files, System.StrUtils,
  btu.sis.db.updater.utils, btu.lib.db.updater.firebird.GetSql_u, Winapi.Windows,
  System.Variants, sis.win.VersionInfo, sis.types.bool.utils;

{ TDBUpdaterFirebird }

constructor TDBUpdaterFirebird.Create(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
  pSisConfig: ISisConfig; pLog: ILog; pOutput: IOutput);
begin
  FArq := pDBMS.LocalDoDBToNomeArq(pLocalDoDB);
  FDatabase := pDBMS.LocalDoDBToDatabase(pLocalDoDB);
  FNomeBanco := pDBMS.LocalDoDBToNomeBanco(pLocalDoDB);

  inherited Create(pLocalDoDB, pDBMS, pSisConfig, pLog, pOutput);
end;

procedure TDBUpdaterFirebird.CrieDB;
var
  sAssunto: string;
  ComandosSQL: string;
begin
  ComandosSQL := 'CREATE DATABASE ''' + FArq + ''' page_size 8192 user ''' +
    'sysdba'' password ''masterkey'';';

  sAssunto :=  'Cria';

  DBMS.ExecInterative(sAssunto, ComandosSQL, LocalDoDB, log, output);
  sleep(200);

end;

function TDBUpdaterFirebird.GetDBExiste: boolean;
var
  sPastaInstDados, sNomeArq, sLog: string;
begin
  sLog := 'TDBUpdaterFirebird.GetDBExiste ini';
  try
    slog := slog + 'vai testar se existe='+FArq;
    result := FileExists(FArq);

    if Result then
    begin
      sLog := sLog + ',existia';
      exit;
    end;
  sLog := sLog + ',nao existia';

  sPastaInstDados := SisConfig.PastaProduto + 'Starter\inst\inst-Firebird\dados\';
  sNomeArq := 'RETAG';
  if SisConfig.WinVersionInfo.Version <= 6.1 then
  begin

  end
  else
  begin
    sNomeArq := sNomeArq + '4';
    if SisConfig.WinVersionInfo.WinPlatform = wplatWin64 then
    begin
      sNomeArq := sNomeArq + '64';
    end
    else
    begin
      sNomeArq := sNomeArq + '32';
    end;
  end;
  sNomeArq := sNomeArq + '.fdb';
  sNomeArq := sPastaInstDados + sNomeArq;
  sLog := sLog + ',vai copiar('+sNomeArq+','+FArq+')';
  CopyFile(PChar(sNomeArq), PChar(FArq), False);

  Result := FileExists(FArq);
  sLog := sLog+',Result='+BooleanToStr(Result);
  finally
    Log.Exibir(sLog);
  end;
end;

function TDBUpdaterFirebird.GetNomeBanco: string;
begin
  Result := 'FIREBIRD';
end;

//function TDBUpdaterFirebird.GetSqlDbUpdateGetMax: string;
//begin
//  Result := GetSqlDBUpdateGetMaxFirebird;
//end;

//function TDBUpdaterFirebird.GetSqlDbUpdateIns: string;
//begin
//  Result := GetSqlDBUpdateInsFirebird;
//end;

end.
