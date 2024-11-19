unit App.UI.Form.Menu.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Menu_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.Actions, Vcl.ActnList;

type
  TAppPDVMenuForm = class(TAppMenuForm)
    BuscaPrecoButton: TButton;
    procedure BuscaPrecoButtonClick(Sender: TObject);
  private
    { Private declarations }
    FPrecoBuscaAction_PDVModuloBasForm: TAction;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; //
      pFecharAction_ModuloBasForm //
      , pOcultarAction_ModuloBasForm //
      , pPrecoBuscaAction_PDVModuloBasForm: TAction); reintroduce;
  end;

var
  AppPDVMenuForm: TAppPDVMenuForm;

implementation

{$R *.dfm}

{ TAppMenuForm1 }

procedure TAppPDVMenuForm.BuscaPrecoButtonClick(Sender: TObject);
begin
  inherited;
  ActionEscolhida := FPrecoBuscaAction_PDVModuloBasForm;
  OkAct_Diag.Execute;
end;

constructor TAppPDVMenuForm.Create(AOwner: TComponent;
  pFecharAction_ModuloBasForm, pOcultarAction_ModuloBasForm,
  pPrecoBuscaAction_PDVModuloBasForm: TAction);
begin
  inherited Create(AOwner, pFecharAction_ModuloBasForm,
    pOcultarAction_ModuloBasForm);
  FPrecoBuscaAction_PDVModuloBasForm := pPrecoBuscaAction_PDVModuloBasForm;
end;

end.
