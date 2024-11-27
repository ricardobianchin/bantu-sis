unit App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Classes,
  System.Variants, Sis.Types.Integers, App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, App.Ent.DBI_u;

type
  TCxOperacaoDBI = class(TEntDBI, ICxOperacaoDBI)
  private
    FCxOperacaoEnt: ICxOperacaoEnt;
    FCxOperacaoDBI: ICxOperacaoDBI;
  protected
    procedure SetVarArrayToId(pNovaId: variant); override;
    procedure RegAtualToEnt(Q: TDataSet); virtual;
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;
  public
    function Ler: boolean; override;
    constructor Create(pDBConnection: IDBConnection; pCxOperacaoEnt: ICxOperacaoEnt);
  end;

implementation

{ TCxOperacaoDBI }

constructor TCxOperacaoDBI.Create(pDBConnection: IDBConnection;
  pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(pDBConnection, pCxOperacaoEnt);
  FCxOperacaoEnt := pCxOperacaoEnt;
end;

function TCxOperacaoDBI.GetFieldNamesListaGet: string;
begin

end;

function TCxOperacaoDBI.GetFieldValuesGravar: string;
begin

end;

function TCxOperacaoDBI.Ler: boolean;
begin

end;

procedure TCxOperacaoDBI.RegAtualToEnt(Q: TDataSet);
begin

end;

procedure TCxOperacaoDBI.SetVarArrayToId(pNovaId: variant);
begin
  inherited;

end;

end.
