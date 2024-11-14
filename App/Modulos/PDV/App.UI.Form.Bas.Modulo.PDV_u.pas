unit App.UI.Form.Bas.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Menus;

type
  TPDVModuloBasForm = class(TModuloBasForm)
    PrecoBuscaAction_ModuloBasForm: TAction;
    N1: TMenuItem;
    ConsultaPreo1: TMenuItem;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PDVModuloBasForm: TPDVModuloBasForm;

implementation

{$R *.dfm}

procedure TPDVModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //
end;

end.
