unit App.Est.Venda.Caixa.CxValor_u;

interface

uses Sis.Types, App.Types, App.Est.Venda.Caixa.CxValor,
  System.Generics.Collections, App.Est.Venda.Caixa.CxNumerarioList;

type
  TCxValor = class(TInterfacedObject, ICxValor)
  private
    FPagamentoFormaId: TId;
    FValor: TPreco;
    FCxNumerarioList: ICxNumerarioList;

    function GetPagamentoFormaId: TId;

    function GetValor: TPreco;
    procedure SetValor(Value: TPreco);

    function GetCxNumerarioList: ICxNumerarioList;
  public
    property PagamentoFormaId: TId read GetPagamentoFormaId;
    property Valor: TPreco read GetValor write SetValor;

    property CxNumerarioList: ICxNumerarioList read GetCxNumerarioList;

    constructor Create(pPagamentoFormaId: TId; pValor: TPreco);
  end;

implementation

uses App.Est.Venda.CaixaSessao.Factory_u;

{ TCxValor }

constructor TCxValor.Create(pPagamentoFormaId: TId; pValor: TPreco);
begin
  FPagamentoFormaId := pPagamentoFormaId;
  FValor := pValor;
  FCxNumerarioList := CxNumerarioListCreate;
end;

function TCxValor.GetCxNumerarioList: ICxNumerarioList;
begin
  Result := FCxNumerarioList;
end;

function TCxValor.GetPagamentoFormaId: TId;
begin
  Result := FPagamentoFormaId;
end;

function TCxValor.GetValor: TPreco;
begin
  Result := FValor;
end;

procedure TCxValor.SetValor(Value: TPreco);
begin
  FValor := Value;
end;

end.
