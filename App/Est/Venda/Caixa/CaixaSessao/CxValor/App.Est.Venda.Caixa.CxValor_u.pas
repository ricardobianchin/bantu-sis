unit App.Est.Venda.Caixa.CxValor_u;

interface

uses Sis.Types, App.Types, App.Est.Venda.Caixa.CxValor, System.Generics.Collections;

type
  TCxValor = class(TInterfacedObject, ICxValor)
  private
    FPagamentoFormaId: TId;
    FValor: TPreco;
//    FCxNumerarioList: TList<ICxNumerario>;

    function GetPagamentoFormaId: TId;
    function GetValor: TPreco;
  public
    property PagamentoFormaId: TId read GetPagamentoFormaId;
    property Valor: TPreco read GetValor;

    procedure PegueCxNumerario(pValor: TPreco; pQtd: SmallInt);

//    function GetCxNumerario(Index: integer): ICxNumerario;
//    property CxNumerario[Index: integer]: ICxNumerario read GetCxNumerario: ICxNumerario; default;

    constructor Create(pPagamentoFormaId: TId; pValor: TPreco);
    destructor Destroy; override;
  end;

implementation

{ TCxValor }

constructor TCxValor.Create(pPagamentoFormaId: TId; pValor: TPreco);
begin
  FPagamentoFormaId := pPagamentoFormaId;
  FValor := pValor;
//  FCxNumerarioList := TList<ICxNumerario>.Create;
end;

destructor TCxValor.Destroy;
begin
//  FCxNumerarioList.Free;
  inherited;
end;

//function TCxValor.GetCxNumerario(Index: integer): ICxNumerario;
//begin
//
//end;

function TCxValor.GetPagamentoFormaId: TId;
begin
  Result := FPagamentoFormaId;
end;

function TCxValor.GetValor: TPreco;
begin
  Result := FValor;
end;

procedure TCxValor.PegueCxNumerario(pValor: TPreco; pQtd: SmallInt);
begin

end;

end.
