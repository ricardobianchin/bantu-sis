unit App.UI.PDV.VendaBasFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.PDV.Frame_u, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TVendaBasPDVFrame = class(TPDVFrame)
    MeioPanel: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VendaBasPDVFrame: TVendaBasPDVFrame;

implementation

{$R *.dfm}

end.
