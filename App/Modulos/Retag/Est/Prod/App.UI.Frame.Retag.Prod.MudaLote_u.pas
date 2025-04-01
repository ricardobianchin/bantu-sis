unit App.UI.Frame.Retag.Prod.MudaLote_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin;

type
  TMudaLoteFrame = class(TBasFrame)
    TipoLabel: TLabel;
    TipoComboBox: TComboBox;
    TitPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure ToolButton1Click(Sender: TObject);
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

uses Sis.UI.ImgDM;

{ TMudaLoteFrame }

constructor TMudaLoteFrame.Create(AOwner: TComponent);
begin
  inherited;
//  Color := RGB(206, 222, 236);
//  TitPanel.Color := RGB(159, 184, 198);
//  ToolBar1.Color := TitPanel.Color;
end;

procedure TMudaLoteFrame.ToolButton1Click(Sender: TObject);
begin
  inherited;
  Visible := False;
end;

end.
