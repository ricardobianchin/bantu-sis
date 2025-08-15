unit Sis.Win.Execute;

interface

uses Sis.UI.IO.Output, Sis.Sis.Executavel;

type
  IWinExecute = interface(IExecutavel)
    ['{8A317294-ADC4-4445-96FE-F24C5D5BF3C6}']
    function Execute: boolean;
    function Executando: boolean;
    procedure EspereExecucao(pOutput: IOutput; pQtdIntervals: integer = 8);

    function GetSaida: string;
    property Saida: string read GetSaida;

    function GetErro: string;
    property Erro: string read GetErro;
  end;

implementation

end.
