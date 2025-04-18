unit App.UI.PDV.VendaBasFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.Frame_u, Vcl.StdCtrls, Vcl.ExtCtrls, App.PDV.DBI, App.PDV.Venda,
  App.PDV.Controlador, App.PDV.Obj;

type
  TVendaBasPDVFrame = class(TPDVFrame)
  private
    { Private declarations }
    FPDVVenda: IPDVVenda;
    FPDVDBI: IAppPDVDBI;
    FPDVControlador: IPDVControlador;

  protected
    property PDVControlador: IPDVControlador read FPDVControlador;
    property PDVDBI: IAppPDVDBI read FPDVDBI;
    property PDVVenda: IPDVVenda read FPDVVenda;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPDVObj: IPDVObj;
      pPDVVenda: IPDVVenda; pPDVDBI: IAppPDVDBI;
      pPDVControlador: IPDVControlador); reintroduce; virtual;
  end;

  // var
  // VendaBasPDVFrame: TVendaBasPDVFrame;

implementation

{$R *.dfm}
{ TVendaBasPDVFrame }

constructor TVendaBasPDVFrame.Create(AOwner: TComponent;
  pPDVObj: IPDVObj; pPDVVenda: IPDVVenda; pPDVDBI: IAppPDVDBI;
  pPDVControlador: IPDVControlador);
begin
  inherited Create(AOwner, pPDVObj);
  FPDVVenda := pPDVVenda;
  FPDVDBI := pPDVDBI;
  FPDVControlador := pPDVControlador;
end;

end.
