unit App.Est.Venda.Caixa.CxValorList_u;

interface

uses App.Est.Venda.Caixa.CxValorList, Sis.Entities.Types,
  App.Est.Venda.Caixa.CxValor, System.Classes, Sis.Types,
  App.Types;

type
  TCxValorList = class(TInterfaceList, ICxValorList)
  private
    function GetCxValor(Index: integer): ICxValor;
    function GetAsList: string;
    function GetNumerarioAsList: string;
  public
    function PegueCxValor(pPagamentoFormaId: TId; pValor: TPreco): ICxValor;
    property CxValor[Index: integer]: ICxValor read GetCxValor; default;
    property AsList: string read GetAsList;
    property NumerarioAsList: string read GetNumerarioAsList;
  end;

implementation

uses App.Est.Venda.CaixaSessao.Factory_u;

{ TCxValorList }

function TCxValorList.GetAsList: string;
var
  oCxValor: ICxValor;
  i: integer;
begin
  Result := '';
  for i := 0 to Count - 1  do
  begin
    oCxValor := CxValor[i];
    if Result <> '' then
      Result := Result + '/';
    Result := Result + oCxValor.PagamentoFormaId.ToString + ','+oCxValor.Valor.AsSqlConstant;
  end;
end;

function TCxValorList.GetCxValor(Index: integer): ICxValor;
begin
  Result := ICxValor(Items[Index]);
end;

function TCxValorList.GetNumerarioAsList: string;
var
  oCxValor: ICxValor;
  i: integer;
begin
  Result := '';
  for i := 0 to Count - 1  do
  begin
    oCxValor := CxValor[i];
    if oCxValor.PagamentoFormaId = 1 then
    begin
      Result := oCxValor.CxNumerarioList.AsList;
      break;
    end;
  end;
end;

function TCxValorList.PegueCxValor(pPagamentoFormaId: TId;
  pValor: TPreco): ICxValor;
begin
  Result := CxValorCreate(pPagamentoFormaId, pValor);
  Add(Result);
end;

end.
