unit App.Retag.Est.Prod.Ed.DBI_u;

interface

uses App.Retag.Est.Prod.Ed.DBI, Sis.DB.DBTypes, Sis.DBI_u;

type
  TRetagEstProdEdDBI = class(TDBI, IRetagEstProdEdDBI)
  private
  public
    procedure PreencherItens(pProdEdForm: TObject);
  end;

implementation

uses App.UI.Form.Ed.Prod_u, Data.DB, System.Classes;

{ TRetagEstProdEdDBI }

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
        1: oForm.FComunsFr.FabrFr.PegarItem(Id, Descr);
        2: oForm.FComunsFr.TipoFr.PegarItem(Id, Descr);
        3: oForm.FComunsFr.UnidFr.PegarItem(Id, Descr);
        4: oForm.FComunsFr.ICMSFr.PegarItem(Id, Descr);
      end;

      q.Next;
    end;
  finally
    DBConnection.Fechar;
  end;

end;

end.
