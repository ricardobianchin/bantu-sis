unit sis.ui.io.output;

interface

uses Vcl.Dialogs;

type
  IOutput = interface(IInterface)
    ['{F5962F4A-FD92-4BD6-947C-99458AFC9D3B}']
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);

//    function GetEnabled: boolean;
//    procedure SetEnabled(Value: boolean);
//    property Enabled: boolean read GetEnabled write SetEnabled;
  end;

implementation

end.
