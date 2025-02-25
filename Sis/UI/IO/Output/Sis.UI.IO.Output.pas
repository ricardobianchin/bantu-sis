unit Sis.UI.IO.Output;

interface

uses Vcl.Dialogs;

type
  IOutput = interface(IInterface)
    ['{F5962F4A-FD92-4BD6-947C-99458AFC9D3B}']
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
    property Ativo: boolean read GetAtivo write SetAtivo;
  end;

implementation

end.

