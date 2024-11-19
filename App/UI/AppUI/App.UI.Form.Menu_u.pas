unit App.UI.Form.Menu_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TAppMenuForm = class(TDiagBasForm)
    FundoPanel_AppMenuForm: TPanel;
    FecharModuloButton_AppMenuForm: TButton;
    OcultarModuloButton_AppMenuForm: TButton;
    OcultarMenuButton_AppMenuForm: TButton;
    procedure FecharModuloButton_AppMenuFormClick(Sender: TObject);
    procedure OcultarMenuButton_AppMenuFormClick(Sender: TObject);
    procedure OcultarModuloButton_AppMenuFormClick(Sender: TObject);
  private
    { Private declarations }
    FActionEscolhida: TAction;
    FFecharAction_ModuloBasForm: TAction;
    FOcultarAction_ModuloBasForm: TAction;
  protected
    property ActionEscolhida: TAction read FActionEscolhida write FActionEscolhida;
  public
    { Public declarations }
    function Perg(out pActionEscolhida: TAction): Boolean;
    constructor Create(AOwner: TComponent; //
      pFecharAction_ModuloBasForm //
      , pOcultarAction_ModuloBasForm //
      : TAction); reintroduce;
  end;

var
  AppMenuForm: TAppMenuForm;

implementation

{$R *.dfm}

{ TDiagBasForm1 }

constructor TAppMenuForm.Create(AOwner: TComponent;
  pFecharAction_ModuloBasForm, pOcultarAction_ModuloBasForm: TAction);
begin
  inherited Create(AOwner);
  FFecharAction_ModuloBasForm := pFecharAction_ModuloBasForm;
  FOcultarAction_ModuloBasForm := pOcultarAction_ModuloBasForm;
end;

procedure TAppMenuForm.FecharModuloButton_AppMenuFormClick(Sender: TObject);
begin
  inherited;
  ActionEscolhida := FFecharAction_ModuloBasForm;
  OkAct_Diag.Execute;
end;

procedure TAppMenuForm.OcultarMenuButton_AppMenuFormClick(Sender: TObject);
begin
  inherited;
  CancelAct_Diag.Execute;
end;

procedure TAppMenuForm.OcultarModuloButton_AppMenuFormClick(Sender: TObject);
begin
  inherited;
  ActionEscolhida := FOcultarAction_ModuloBasForm;
  OkAct_Diag.Execute;
end;

function TAppMenuForm.Perg(out pActionEscolhida: TAction): Boolean;
begin
  Result := inherited Perg;
  pActionEscolhida := ActionEscolhida;
end;

end.
