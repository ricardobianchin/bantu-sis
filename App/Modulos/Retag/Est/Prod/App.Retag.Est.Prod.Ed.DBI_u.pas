unit App.Retag.Est.Prod.Ed.DBI_u;

interface

uses App.Retag.Est.Prod.Ed.DBI, Sis.DB.DBTypes, Sis.DBI_u, System.Classes;

type
  TRetagEstProdEdDBI = class(TDBI, IRetagEstProdEdDBI)
  private
  public
    procedure PreencherItens(pProdEdForm: TObject);
    function FabrDescrsExistentes(pProdIdExceto: integer; pFabrId: smallint;
      pDescr, pDescrRed: string; pResultSL: TStringList): boolean;
  end;

implementation

uses App.UI.Form.Ed.Prod_u, Data.DB, System.SysUtils, Sis.Types.Bool_u;

{ TRetagEstProdEdDBI }

function TRetagEstProdEdDBI.FabrDescrsExistentes(pProdIdExceto: integer;
  pFabrId: smallint; pDescr, pDescrRed: string; pResultSL: TStringList)
  : boolean;
var
  oForm: TProdEdForm;
  q: TDataSet;
  sSql: string;
  ProdId: integer;
  Descr: string;
  DescrRed: string;
  sLinha: string;
  sFormat: string;
begin
  Result := False;

  sFormat := 'SELECT PROD_ID_RET, DESCR_RET, DESCR_RED_RET' +
    ' FROM RETAG_PROD_ED_PA.FABR_DESCRS_EXISTENTES_GET(%d, %d,''%s'',''%s'');';

  sSql := Format(sFormat, [pProdIdExceto, pFabrId, pDescr, pDescrRed]);
  pResultSL.Clear;

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    while not q.Eof do
    begin
      ProdId := q.Fields[0].AsInteger;
      Descr := q.Fields[1].AsString;
      DescrRed := q.Fields[2].AsString;

      if Descr = pDescr then
      begin
        sLinha := '1' + ProdId.ToString + '-' + Descr;
        pResultSL.Add(sLinha);
      end;

      if DescrRed = pDescrRed then
      begin
        sLinha := '2' + ProdId.ToString + '-' + DescrRed;
        pResultSL.Add(sLinha);
      end;

      q.Next;
    end;
    Result := True;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TRetagEstProdEdDBI.PreencherItens(pProdEdForm: TObject);
var
  oForm: TProdEdForm;
  q: TDataSet;
  sSql: string;
  RegTipo: smallint;
  Id: integer;
  Descr: string;
begin
  oForm := TProdEdForm(pProdEdForm);

  oForm.FComunsFr.FabrFr.Limpar;
  oForm.FComunsFr.TipoFr.Limpar;
  oForm.FComunsFr.UnidFr.Limpar;
  oForm.FComunsFr.ICMSFr.Limpar;

  sSql := 'SELECT REGTIPO, ID_RET, DESCR_RET FROM RETAG_PROD_ED_PA.ITEMS_GET;';
  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    while not q.Eof do
    begin
      RegTipo := q.Fields[0].AsInteger;
      Id := q.Fields[1].AsInteger;
      Descr := q.Fields[2].AsString;

      case RegTipo of
        1:
          oForm.FComunsFr.FabrFr.PegarItem(Id, Descr);
        2:
          oForm.FComunsFr.TipoFr.PegarItem(Id, Descr);
        3:
          oForm.FComunsFr.UnidFr.PegarItem(Id, Descr);
        4:
          oForm.FComunsFr.ICMSFr.PegarItem(Id, Descr);
      end;

      q.Next;
    end;

    oForm.FComunsFr.FabrFr.EntIdToItem;
    oForm.FComunsFr.TipoFr.EntIdToItem;
    oForm.FComunsFr.UnidFr.EntIdToItem;
    oForm.FComunsFr.ICMSFr.EntIdToItem;

  finally
    DBConnection.Fechar;
  end;

end;

end.
