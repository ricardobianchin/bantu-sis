unit btu.lib.db.updater.firebird_u;

interface

uses
  btu.lib.db.updater_u, btu.lib.config, btu.sis.ui.io.log, btu.sis.ui.io.output,
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
    function GetDBExite: boolean; override;
    procedure CrieDB; override;
//    function GetSqlDbUpdateIns: string; override;
//    function GetSqlDbUpdateGetMax: string; override;
  public
    constructor Create(pLocalDoDB: TLocalDoDB; pDBMS: IDBMS;
      pSisConfig: ISisConfig; pLog: ILog; pOutput: IOutput);
  end;

implementation

uses
  btu.lib.db.firebird.utils, System.SysUtils, btu.lib.files, System.StrUtils,
  btu.sis.db.updater.utils, btu.lib.db.updater.firebird.GetSql_u,
  System.Variants;

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
  PastaTmp: string;
  sAssunto: string;
  ComandosSQL: string;
begin
  ComandosSQL := 'CREATE DATABASE ''' + FArq + ''' page_size 8192 user ''' +
    'sysdba'' password ''masterkey'';';

  sAssunto :=  'Cria banco ' + FNomeBanco;

  DBMS.ExecInterative(sAssunto, ComandosSQL, LocalDoDB, log, output);
end;

function TDBUpdaterFirebird.GetDBExite: boolean;
begin
  result := FileExists(FArq);
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
