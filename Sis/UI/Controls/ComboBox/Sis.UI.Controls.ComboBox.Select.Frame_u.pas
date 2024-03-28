unit Sis.UI.Controls.ComboBox.Select.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Controls.ComboBox.Frame_u,
  Vcl.StdCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.ExtCtrls;

type
  TComboBoxSelectBasFrame = class(TComboBoxBasFrame)
    BuscaSpeedButton: TSpeedButton;
    Espacador2Label: TLabel;
  private
    { Private declarations }
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  ComboBoxSelectBasFrame: TComboBoxSelectBasFrame;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM;

{ TComboBoxSelectBasFrame }

constructor TComboBoxSelectBasFrame.Create(AOwner: TComponent);
begin
  inherited;
  ControlsPanel.Width := BuscaSpeedButton.Left + BuscaSpeedButton.Width + 1;
  Width := ControlsPanel.Width;
end;

end.
