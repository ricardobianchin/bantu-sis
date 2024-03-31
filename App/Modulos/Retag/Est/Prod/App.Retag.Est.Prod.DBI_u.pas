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
    procedure SetNovaId(pIds: variant); override;
  public
    constructor Create(pDBConnection: IDBConnection; pEntEd: IEntEd);
    procedure InsertInto;
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



function TProdDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT PROD_ID, DESCR, DESCR_RED, FABR_ID, FABR_NOME' +
    ' FROM PROD_PA.LISTA_GET;';
end;

procedure TProdDBI.InsertInto;
begin

end;

procedure TProdDBI.SetNovaId(pIds: variant);
begin
  inherited;
  FProdEnt.Id := VarToInteger(pIds);
end;

end.
