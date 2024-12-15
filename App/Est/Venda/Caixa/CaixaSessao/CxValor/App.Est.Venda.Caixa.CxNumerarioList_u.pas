unit App.Est.Venda.Caixa.CxNumerarioList_u;

interface

uses Sis.Entities.Types, App.Est.Venda.Caixa.CxNumerario,
  App.Est.Venda.Caixa.CxNumerarioList, System.Classes,
  Sis.Types, App.Types;

type
  TCxNumerarioList = class(TInterfaceList, ICxNumerarioList)
  private
    FCxNumerarioList: ICxNumerarioList;

    function GetCxNumerario(Index: integer): ICxNumerario;
  public
    function PegueCxNumerario(pValor: TPreco; pQtd: SmallInt): ICxNumerario;
    property CxNumerario[Index: integer]: ICxNumerario read GetCxNumerario;
  end;

implementation

uses App.Est.Venda.CaixaSessao.Factory_u;

{ TCxNumerarioList }

function TCxNumerarioList.GetCxNumerario(Index: integer): ICxNumerario;
begin
  Result := ICxNumerario(Items[Index])
end;

function TCxNumerarioList.PegueCxNumerario(pValor: TPreco;
  pQtd: SmallInt): ICxNumerario;
begin
  Result := CxNumerarioCreate(pValor, pQtd);
  FCxNumerarioList.Add(Result);
end;

end.
