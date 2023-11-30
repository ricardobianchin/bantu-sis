unit App.UI.Form.Bas.Princ.Modulos_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Princ_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage;

type
  TModulosPrincBasForm = class(TPrincBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModulosPrincBasForm: TModulosPrincBasForm;

implementation

{$R *.dfm}

procedure TModulosPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  OculteStatusForm;
end;

end.
