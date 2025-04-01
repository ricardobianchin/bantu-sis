unit App.UI.Frame.Retag.Prod.MudaLote_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TMudaLoteFrame = class(TBasFrame)
    TipoLabel: TLabel;
    ComboBox1: TComboBox;
    TitPanel: TPanel;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

//var
//  MudaLoteFrame: TMudaLoteFrame;

implementation

{$R *.dfm}

{ TMudaLoteFrame }

constructor TMudaLoteFrame.Create(AOwner: TComponent);
begin
  inherited;
  Color := RGB(206, 222, 236);
end;

end.
