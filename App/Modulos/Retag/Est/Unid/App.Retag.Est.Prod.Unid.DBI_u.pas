unit App.Retag.Est.Prod.Unid.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Unid.Ent, Sis.UI.Frame.Bas.Filtro_u;

type
  TProdUnidDBI = class(TEntDBI)
  private
    function GetProdUnidEnt: IProdUnidEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGaranteRegRetId: string; override;
    procedure SetVarArrayToId(pNovaId: Variant); override;
    function GetPackageName: string; override;
  public
    function GetExistente(pValues: variant; out pRetorno: string)
      : variant; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u,
  Sis.Win.Utils_u, Vcl.Dialogs, App.Retag.Est.Factory;

{ TProdUnidDBI }

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

function TProdUnidDBI.GetPackageName: string;
begin
  Result := 'UNID_PA';
end;

function TProdUnidDBI.GetProdUnidEnt: IProdUnidEnt;
begin
  Result := EntEdCastToProdUnidEnt(EntEd);

end;

function TProdUnidDBI.GetSqlGaranteRegRetId: string;
var
  sFormat: string;
begin
  sFormat := 'SELECT ID_GRAVADO' +
    ' FROM UNID_PA.GARANTIR(%d,''%s'',''%s'');';
  Result := Format(sFormat, [GetProdUnidEnt.Id, GetProdUnidEnt.Descr,
    GetProdUnidEnt.Sigla]);
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
  Result := Format(sFormat, [GetProdUnidEnt.Id, sDescr, sSigla]);
end;

function TProdUnidDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := 'SELECT UNID_ID, DESCR, SIGLA FROM UNID_PA.LISTA_GET;';
end;

procedure TProdUnidDBI.SetVarArrayToId(pNovaId: Variant);
begin
  inherited;
  GetProdUnidEnt.Id := VarToInteger(pNovaId[0]);
end;

end.
