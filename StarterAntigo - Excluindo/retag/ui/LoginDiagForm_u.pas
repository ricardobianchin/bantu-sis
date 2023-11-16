unit LoginDiagForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DiagForm_u, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, usu_u, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TLoginDiagForm = class(TDiagForm)
    UserNameLabeledEdit: TLabeledEdit;
    PasswordLabeledEdit: TLabeledEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ActionListLogin: TActionList;
    ExibirSenhaAction: TAction;
    OcultarSenhaAction: TAction;
    ToolButton2: TToolButton;
    Image1: TImage;
    FundoPanel: TPanel;
    TopoPanel: TPanel;
    Image2: TImage;
    Label1: TLabel;
    procedure UserNameLabeledEditChange(Sender: TObject);
    procedure PasswordLabeledEditChange(Sender: TObject);
    procedure PasswordLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure UserNameLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ExibirSenhaActionExecute(Sender: TObject);
    procedure OcultarSenhaActionExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    function PodeOk: boolean; override;
  public
    { Public declarations }
    Usu: TUsu;
  end;

function FezLogin(pUsu: TUsu): boolean;

var
  LoginDiagForm: TLoginDiagForm;

implementation

{$R *.dfm}

uses types, btu.lib.ui.Img.DataModule, btn.lib.types.strings;

function FezLogin(pUsu: TUsu): boolean;
var
  r: TModalResult;
begin
  LoginDiagForm := TLoginDiagForm.Create(nil);
  try
    LoginDiagForm.Usu := pUsu;
    r := LoginDiagForm.ShowModal;
    Result := r = mrOk;

//    if not Result then
//      exit;
  finally
    LoginDiagForm.Free;
  end;
end;

procedure TLoginDiagForm.ExibirSenhaActionExecute(Sender: TObject);
begin
  inherited;
  ExibirSenhaAction.Visible:=false;
  OcultarSenhaAction.Visible:=true;
  PasswordLabeledEdit.PasswordChar := #0;
end;

procedure TLoginDiagForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key=#27 then
  begin
    key := #0;
    CancAction.Execute;
  end;
end;

procedure TLoginDiagForm.FormShow(Sender: TObject);
begin
  inherited;
  UserNameLabeledEdit.SetFocus;
end;

procedure TLoginDiagForm.OcultarSenhaActionExecute(Sender: TObject);
begin
  inherited;
  ExibirSenhaAction.Visible:=true;
  OcultarSenhaAction.Visible:=false;
  PasswordLabeledEdit.PasswordChar := '*';
end;

procedure TLoginDiagForm.PasswordLabeledEditChange(Sender: TObject);
begin
  inherited;
  ErroLabel.Caption := '';

end;

procedure TLoginDiagForm.PasswordLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = #13 then
  begin
    Key := #0;
    OkAction.Execute;
    exit;
  end;

  btn.lib.types.strings.CharSemAcento(Key);
end;

function TLoginDiagForm.PodeOk: boolean;
begin
  UserNameLabeledEdit.Text := Trim(UserNameLabeledEdit.Text);
  result := UserNameLabeledEdit.Text <> '';
  if not result then
  begin
    ErroLabel.Caption := 'Nome de usuário é obrigatório';
    UserNameLabeledEdit.SetFocus;
    exit;
  end;

  PasswordLabeledEdit.Text := Trim(PasswordLabeledEdit.Text);
  result := PasswordLabeledEdit.Text <> '';
  if not result then
  begin
    ErroLabel.Caption := 'Senha é obrigatória';
    PasswordLabeledEdit.SetFocus;
    exit;
  end;

 Result :=
  (UserNameLabeledEdit.Text = 'ADM')
  and
  (PasswordLabeledEdit.Text = '123');

  if result then
    exit;

  ErroLabel.Caption := 'Nome de usuário ou senha incorretos';
  UserNameLabeledEdit.SetFocus;


end;

procedure TLoginDiagForm.UserNameLabeledEditChange(Sender: TObject);
begin
  inherited;
  ErroLabel.Caption := '';

end;

procedure TLoginDiagForm.UserNameLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = #13 then
  begin
    Key := #0;
    PasswordLabeledEdit.SetFocus;
    exit;
  end;

  btn.lib.types.strings.CharSemAcento(Key);
end;

end.
