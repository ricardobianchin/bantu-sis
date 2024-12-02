unit App.Est.Venda.Caixa.CxNumerario_u;

interface

uses Sis.Types, App.Types, App.Est.Venda.Caixa.CxNumerario;

type
  TCxNumerario = class(TInterfacedObject, ICxNumerario)
  private
    FValor: TPreco;
    FQtd: SmallInt;

    function GetValor: TPreco;
    function GetQtd: SmallInt;
  public
    property Valor: TPreco read GetValor;
    property Qtd: SmallInt read GetQtd;

    constructor Create(pValor: TPreco; pQtd: SmallInt);
  end;

implementation

{ TCxNumerario }

constructor TCxNumerario.Create(pValor: TPreco; pQtd: SmallInt);
begin
  FValor := pValor;
  FQtd := pQtd;
end;

function TCxNumerario.GetQtd: SmallInt;
begin
  Result := FQtd;
end;

function TCxNumerario.GetValor: TPreco;
begin
  Result := FValor;
end;

end.
