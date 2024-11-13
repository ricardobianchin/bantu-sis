unit App.PDV.Preco.PrecoBusca.Um.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls;

type
  TPrecoBuscaUmFrame = class(TBasFrame)
    PrecoLabel: TLabel;
    DescrLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrecoBuscaUmFrame: TPrecoBuscaUmFrame;

implementation

{$R *.dfm}

end.
