unit Sis.UI.Controls.ComboBox.Select.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Controls.ComboBox.Frame_u,
  Vcl.StdCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList;

type
  TComboBoxSelectBasFrame = class(TComboBoxBasFrame)
    BuscaSpeedButton: TSpeedButton;
    Espacador2Label: TLabel;
  private
    { Private declarations }
  protected
  public
    { Public declarations }
  end;

var
  ComboBoxSelectBasFrame: TComboBoxSelectBasFrame;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM;

{ TComboBoxSelectBasFrame }

end.
