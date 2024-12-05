unit App.Est.Venda.Caixa.CxValor_u;

interface

uses Sis.Types, App.Types, App.Est.Venda.Caixa.CxValor,
  System.Generics.Collections, App.Est.Venda.Caixa.CxNumerario;

type
  TCxValor = class(TInterfacedObject, ICxValor)
  private
    FPagamentoFormaId: TId;
    FValor: TPreco;
    FCxNumerarioList: TList<ICxNumerario>;

    function GetPagamentoFormaId: TId;
    function GetValor: TPreco;
    function GetCxNumerario(Index: integer): ICxNumerario;
  public
    property PagamentoFormaId: TId read GetPagamentoFormaId;
    property Valor: TPreco read GetValor;

    function PegueCxNumerario(pValor: TPreco; pQtd: SmallInt): ICxNumerario;

    property CxNumerario[Index: integer]: ICxNumerario
      read GetCxNumerario; default;

    constructor Create(pPagamentoFormaId: TId; pValor: TPreco);
    destructor Destroy; override;
  end;

implementation

uses App.Est.Venda.CaixaSessao.Factory_u;

{ TCxValor }

constructor TCxValor.Create(pPagamentoFormaId: TId; pValor: TPreco);
begin
  FPagamentoFormaId := pPagamentoFormaId;
  FValor := pValor;
  FCxNumerarioList := TList<ICxNumerario>.Create;
end;

destructor TCxValor.Destroy;
begin
  FCxNumerarioList.Free;
  inherited;
end;

function TCxValor.GetCxNumerario(Index: integer): ICxNumerario;
begin
  Result := FCxNumerarioList[Index];
end;

function TCxValor.GetPagamentoFormaId: TId;
begin
  Result := FPagamentoFormaId;
end;

function TCxValor.GetValor: TPreco;
begin
  Result := FValor;
end;

function TCxValor.PegueCxNumerario(pValor: TPreco; pQtd: SmallInt): ICxNumerario;
begin
  Result := CxNumerarioCreate(pValor, pQtd);
  FCxNumerarioList.Add(Result);
end;

end.
