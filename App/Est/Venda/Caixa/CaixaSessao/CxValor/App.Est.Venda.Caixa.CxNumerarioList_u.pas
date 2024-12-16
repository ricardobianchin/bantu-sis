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
    function GetAsList: string;
  public
    function PegueCxNumerario(pValor: TPreco; pQtd: SmallInt): ICxNumerario;
    property CxNumerario[Index: integer]: ICxNumerario read GetCxNumerario; default;
    property AsList: string read GetAsList;
  end;

implementation

uses App.Est.Venda.CaixaSessao.Factory_u, System.SysUtils;

{ TCxNumerarioList }

function TCxNumerarioList.GetAsList: string;
var
  oCxNumerario: ICxNumerario;
  i: integer;
begin
  Result := '';
  for i := 0 to Count - 1  do
  begin
    oCxNumerario := CxNumerario[i];
    if Result <> '' then
      Result := Result + '/';
    Result := Result + oCxNumerario.Valor.AsSqlConstant + '*'+oCxNumerario.Qtd.ToString;
  end;
end;

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
