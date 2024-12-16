unit App.Est.Venda.Caixa.CxNumerarioList;

interface

uses Sis.Entities.Types, App.Est.Venda.Caixa.CxNumerario, System.Classes,
  Sis.Types, App.Types;

type
  ICxNumerarioList = interface(IInterfaceList)
    ['{5DEAED15-C7BC-4B1C-ACF8-BC5B95E730F4}']
    function PegueCxNumerario(pValor: TPreco; pQtd: SmallInt): ICxNumerario;
    function GetCxNumerario(Index: integer): ICxNumerario;
    property CxNumerario[Index: integer]: ICxNumerario read GetCxNumerario; default;
    function GetAsList: string;
    property AsList: string read GetAsList;
  end;

implementation

end.
