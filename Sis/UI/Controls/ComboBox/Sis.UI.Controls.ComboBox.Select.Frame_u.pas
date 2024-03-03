unit Sis.UI.Controls.ComboBox.Select.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Controls.ComboBox.Frame_u,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TComboBoxSelectBasFrame = class(TComboBoxBasFrame)
    BuscaSpeedButton: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ComboBoxSelectBasFrame: TComboBoxSelectBasFrame;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM;

end.
