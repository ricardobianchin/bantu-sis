unit btu.lib.ui.FormBasico.Act.Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, btu.lib.ui.FormBasico.Act, System.Actions,
  Vcl.ActnList, btu.lib.types.bool.ProcQueryBoolean, btu.lib.ui.FormDecorator;

type
  TFormBasActDialog = class(TFormBasAct)
    BasDiagOkAct: TAction;
    BasDiagCancelarAct: TAction;
    procedure BasDiagOkActExecute(Sender: TObject);
    procedure BasDiagCancelarActExecute(Sender: TObject);
  private
    { Private declarations }
    FoTestaOk: IProcQueryBoolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pTestaOk: IProcQueryBoolean; ADecorators: array of IFormDecorator);reintroduce;
  end;

var
  FormBasActDialog: TFormBasActDialog;

implementation

{$R *.dfm}

procedure TFormBasActDialog.BasDiagCancelarActExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;

end;

procedure TFormBasActDialog.BasDiagOkActExecute(Sender: TObject);
begin
  inherited;
  if not FoTestaOk.GetBoolean then
    exit;

  ModalResult := mrOk;
end;

constructor TFormBasActDialog.Create(AOwner: TComponent; pTestaOk: IProcQueryBoolean; ADecorators: array of IFormDecorator);
begin
  inherited Create(AOwner, ADecorators);
  FoTestaOk := pTestaOk;
end;

end.
