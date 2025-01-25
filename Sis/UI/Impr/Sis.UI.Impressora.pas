unit Sis.UI.Impressora;

interface

type
  IImpressora = interface(IInterface)
    ['{D923E484-AEAB-4BED-8152-AEA2B87A41D5}']
    function Abrir(pDocTitulo: string): Boolean;
    procedure Fechar;

    function GetAberta: Boolean;
    procedure SetAberta(Value: Boolean);
    property Aberta: Boolean read GetAberta write SetAberta;

    function GetNome: string;
    property Nome: string read GetNome;
  end;

implementation

end.
