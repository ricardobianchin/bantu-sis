unit App.UI.PDV.VendaBasFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.PDV.Frame_u, Vcl.StdCtrls,
  Vcl.ExtCtrls, App.PDV.Venda;

type
  TVendaBasPDVFrame = class(TPDVFrame)
    MeioPanel: TPanel;
  private
    { Private declarations }
    FPDVVenda: IPDVVenda;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPDVVenda: IPDVVenda); reintroduce; virtual;
  end;

//var
//  VendaBasPDVFrame: TVendaBasPDVFrame;

implementation

{$R *.dfm}

{ TVendaBasPDVFrame }

constructor TVendaBasPDVFrame.Create(AOwner: TComponent; pPDVVenda: IPDVVenda);
begin
  inherited Create(AOwner);
  FPDVVenda := pPDVVenda
end;

end.
