unit App.UI.PDV.PagFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls;

type
  TPagPDVFrame = class(TVendaBasPDVFrame)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PagSomenteDinheiro;
  end;

var
  PagPDVFrame: TPagPDVFrame;

implementation

{$R *.dfm}

{ TPagPDVFrame }

procedure TPagPDVFrame.PagSomenteDinheiro;
begin

end;

end.
