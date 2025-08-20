unit Sis.Win.ShortCutCreator;

interface

uses Sis.Sis.Executavel;

type
  IShortCutCreator = interface(IExecutavel)
    ['{94D1179C-3AAB-41B8-AC75-6836FF3FFE14}']
    procedure Inicialize(pAssunto, pPastaComandos, pPastaDesktop: string);
    procedure AddScriptFor(pNomeAtalho, pExe, pParams, pStartIn: string);

    function GetMens: string;
    property Mens: string read GetMens;
  end;

implementation

end.
