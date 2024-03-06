unit App.Retag.Est.Prod.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u,
  App.Retag.Est.Prod.Ent, Sis.UI.Frame.Bas.FiltroParams_u,
  App.Retag.Est.Prod.DBI, App.Ent.Ed, App.Retag.Est.Factory;

type
  TProdDBI = class(TEntDBI, IProdDBI)
  private
    FProdEnt: IProdEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pIds: variant); override;
  public
    function GetExistente(pValues: variant; out pRetorno: string)
      : variant; override;

    constructor Create(pDBConnection: IDBConnection; pEntEd: IEntEd);
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TProdDBI }

constructor TProdDBI.Create(pDBConnection: IDBConnection; pEntEd: IEntEd);
begin
  inherited Create(pDBConnection);
  FProdEnt := EntEdCastToProdEnt(pEntEd);
end;

function TProdDBI.GetExistente(pValues: variant; out pRetorno: string): variant;
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
        pRetorno := pRetorno + 'Cod: ' + q.Fields[0].AsString + ', Descr: ' +
          q.Fields[1].AsString + ', DescrRed: ' + q.Fields[2].AsString +
          ', Fabr: ' + q.Fields[2].AsString;
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

function TProdDBI.GetSqlGarantirRegId: string;
var
  sFormat: string;
  sId, sDescr, sDescrRed, sFabrId, sFabrNome: string;
begin
  sId := FProdEnt.Id.ToString;
  sDescr := QuotedStr(FProdEnt.Descr);
  sDescrRed := QuotedStr(FProdEnt.DescrRed);
  sFabrId := FProdEnt.ProdFabrEnt.Id.ToString;
  sFabrNome := QuotedStr(FProdEnt.ProdFabrEnt.Descr);

  sFormat := 'SELECT ID_GRAVADO FROM PROD_PA.GARANTIR(%s,%s,%s,%s);';
  Result := Format(sFormat, [sId, sDescr, sDescrRed, sFabrId]);
end;

function TProdDBI.GetSqlGetExistente(pValues: variant): string;
var
  sFormat: string;
  sIdExceto, sDescr, sDescrRed, sFabrId: string;
begin
  sIdExceto := StrToIntStr(VarToString(pValues[0]));
  sDescr := QuotedStr(VarToString(pValues[1]));
  sDescrRed := QuotedStr(VarToString(pValues[2]));
  sFabrId := StrToIntStr(VarToString(pValues[3]));

  sFormat := 'SELECT PROD_ID_RET, DESCR_RET, DESCR_RED_RET, FABR_ID_RET,' +
    ' FABR_NOME_RET FROM PROD_PA.EXISTENTES_GET(%s, %s, %s, %s);';

  Result := Format(sFormat, [sIdExceto, sDescr, sDescrRed, sFabrId]);
end;

function TProdDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT PROD_ID, DESCR, DESCR_RED, FABR_ID, FABR_NOME' +
    ' FROM PROD_PA.LISTA_GET;';
end;

procedure TProdDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdEnt.Id := VarToInteger(pIds);
end;

end.
