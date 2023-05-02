unit lib.ui.FormBasico.Act.Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, lib.ui.FormBasico.Act, System.Actions,
  Vcl.ActnList, lib.types.Booleans;

type
  TFormBasActDialog = class(TFormBasAct)
    BasDiagOkAct: TAction;
    BasDiagCancelarAct: TAction;
    procedure BasDiagOkActExecute(Sender: TObject);
    procedure BasDiagCancelarActExecute(Sender: TObject);
  private
    { Private declarations }
    FoTestaOk: IGetBoolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pTestaOk: IGetBoolean);reintroduce;
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

constructor TFormBasActDialog.Create(AOwner: TComponent; pTestaOk: IGetBoolean);
begin
  inherited Create(AOwner);
  FoTestaOk := pTestaOk;
end;

end.
