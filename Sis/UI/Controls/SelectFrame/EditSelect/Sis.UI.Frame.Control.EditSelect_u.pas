unit Sis.UI.Frame.Control.EditSelect_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TControlBasFrame1 = class(TControlBasFrame)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ControlBasFrame1: TControlBasFrame1;

implementation

{$R *.dfm}

end.
