unit App.Retag.Est.Prod.Unid.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Unid.Ent, Sis.UI.Frame.Bas.FiltroParams_u;

type
  TProdUnidDBI = class(TEntDBI)
  private
    FProdUnidEnt: IProdUnidEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pIds: variant); override;
  public
    function GetExistente(pValues: variant; out pRetorno: string)
      : variant; override;
    constructor Create(pDBConnection: IDBConnection; pEntEd: IProdUnidEnt);
  end;

implementation

uses System.SysUtils, App.Retag.Est.Prod.Unid.Ent_u, Sis.Types.strings_u,
  Sis.Win.Utils_u, Vcl.Dialogs;

{ TProdUnidDBI }

constructor TProdUnidDBI.Create(pDBConnection: IDBConnection;
  pEntEd: IProdUnidEnt);
begin
  inherited Create(pDBConnection);
  FProdUnidEnt := TProdUnidEnt(pEntEd);
end;

function TProdUnidDBI.GetExistente(pValues: variant;
  out pRetorno: string): variant;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  sResultado: string;
  bResultado: boolean;
begin
  Result := '';
  pRetorno := '';
  sResultado := '';

  sSql := GetSqlGetExistente(pValues);
  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    try
    bResultado := Assigned(q);
    if not bResultado then
      exit;

    bResultado := q.IsEmpty;
    if bResultado then
      exit;

    bResultado := q.Fields[0].AsInteger = 0;
    if bResultado then
      exit;

    while not q.Eof do
    begin
      if sResultado <> '' then
        sResultado := sResultado + ',';
      sResultado := sResultado + q.Fields[0].AsString;

      if pRetorno <> '' then
        pRetorno := pRetorno + ',';
      pRetorno := pRetorno + q.Fields[1].AsString + ',' + q.Fields[2].AsString;
      q.Next;
    end;

    if pRetorno <> '' then
    begin
      pRetorno := 'Já existente: ' + pRetorno;
      Result := sResultado;
    end;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

function TProdUnidDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT ID_GRAVADO' +
    ' FROM UNID_PA.GARANTIR(%d,''%s'',''%s'');';
  Result := Format(sFormat, [FProdUnidEnt.Id, FProdUnidEnt.Descr,
    FProdUnidEnt.Sigla]);
end;

function TProdUnidDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  sDescr: string;
  sSigla: string;
begin
  sDescr := VarToString(pValues[0]);
  sSigla := VarToString(pValues[1]);

  sFormat := 'SELECT UNID_ID_RET, DESCR_RET, SIGLA_RET'
    + ' FROM UNID_PA.EXISTENTES_GET(%d,''%s'',''%s'');';
  Result := Format(sFormat, [FProdUnidEnt.Id, sDescr, sSigla]);
end;

function TProdUnidDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT UNID_ID, DESCR, SIGLA FROM UNID_PA.LISTA_GET;';
end;

procedure TProdUnidDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdUnidEnt.Id := VarToInteger(pIds);
end;

end.
