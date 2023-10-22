unit btu.lib.db.updater.comando;

interface

uses classes, sis.ui.io.log, sis.ui.io.output;

type
  IComando = interface(IInterface)
    ['{4C487CD4-971E-48CB-B1BE-56EE6D6B37D4}']
//    procedure PegarObjeto(pNome: string);
    procedure PegarLinhas(var piLin: integer; pSL: TStrings);
    function GetAsSql: string;
    function Funcionou: boolean;

    function GetUltimoErro: string;
    property UltimoErro: string read GetUltimoErro;

    function GetLog: ILog;
    property Log: ILog read GetLog;

    function GetOutput: IOutput;
    property Output: IOutput read GetOutput;

    function GetAsText: string;
    property AsText: string read GetAsText;
  end;

implementation

end.
