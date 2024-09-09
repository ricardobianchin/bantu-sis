unit App.UI.Form.Bas.Ed.Pess.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed.Pess_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Pess.Loja.Ent.Factory_u, App.Pess.Loja.DBI,
  App.Pess.Loja.Ent, App.AppInfo, App.Ent.Ed, App.Ent.DBI, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TPessLojaEdForm = class(TPessEdBasForm)
    SelecionadoCheckBox: TCheckBox;
    LojaIdLabel: TLabel;
    LojaIdEdit: TEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure SelecionadoCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure LojaIdEditExit(Sender: TObject);
  private
    { Private declarations }
    FPessLojaEnt: IPessLojaEnt;
    FPessLojaDBI: IPessLojaDBI;

    function LojaIdDigitada: smallint;
    function LojaIdOk: boolean;
  protected
    procedure AjusteTabOrder; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function DadosOk: boolean; override;
    function NomeFantasiaOk: boolean; override;
    function ApelidoOk: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessLojaEdForm: TPessLojaEdForm;

implementation

{$R *.dfm}

uses Sis.Types.Codigos.Utils, Sis.UI.Controls.Utils, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.UI.ImgDM;

procedure TPessLojaEdForm.AjusteTabOrder;
var
  iTabOrder: integer;
begin
  inherited;
  iTabOrder := AtivoPessCheckBox.TabOrder + 1;
  SelecionadoCheckBox.TabOrder := iTabOrder; Inc(iTabOrder);
  LojaIdEdit.TabOrder := iTabOrder;
end;

procedure TPessLojaEdForm.SelecionadoCheckBoxKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  CheckBoxKeyPress(Sender, Key);
end;

function TPessLojaEdForm.ApelidoOk: boolean;
begin
  Result := not ApelidoPessLabel.Visible;

  if Result then
    exit;

  ApelidoPessEdit.Text := Trim(ApelidoPessEdit.Text);
  Result := ApelidoPessEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir(ApelidoPessLabel.Caption + ' é obrigatório');
  ApelidoPessEdit.SetFocus
end;

procedure TPessLojaEdForm.ControlesToEnt;
begin
  inherited;
  FPessLojaEnt.Selecionado := SelecionadoCheckBox.Checked;
  FPessLojaEnt.LojaId := StrToInt(LojaIdEdit.Text);
end;

constructor TPessLojaEdForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pAppInfo, pEntEd, pEntDBI);
  FPessLojaEnt := EntEdCastToPessLojaEnt(pEntEd);
  FPessLojaDBI := EntDBICastToPessLojaDBI(pEntDBI);

  SelecionadoCheckBox.Hint := 'Ligado indica que este registro se refere ao'
    + ' estabelecimento a que pertence o sistema.'#13#10
    + 'Desligado, indica que se refere a outro estabelecimento da rede.'#13#10
    + 'Ao ligar esta opção, ela será desligada nos demais registros';

end;

function TPessLojaEdForm.DadosOk: boolean;
begin
  Result := Inherited;
  if not Result then
    exit;

  Result := LojaIdOk;
  if not Result then
    exit;
end;

procedure TPessLojaEdForm.EntToControles;
begin
  inherited;
  SelecionadoCheckBox.Checked := FPessLojaEnt.Selecionado;
  if FPessLojaEnt.LojaId < 1 then
    LojaIdEdit.Text := ''
  else
    LojaIdEdit.Text := FPessLojaEnt.LojaId.ToString;

  LojaIdEdit.ReadOnly := FPessLojaEnt.State <> dsInsert;
end;

function TPessLojaEdForm.LojaIdDigitada: smallint;
begin
  Result := StrToSmallInt(LojaIdEdit.Text);
end;

procedure TPessLojaEdForm.LojaIdEditExit(Sender: TObject);
begin
  inherited;
  LojaIdEdit.Text := StrToOnlyDigit(LojaIdEdit.Text);

end;

function TPessLojaEdForm.LojaIdOk: boolean;
var
  iLojaId: SmallInt;
  sApelido: string;
begin
  iLojaId := LojaIdDigitada;
  Result := iLojaId > 0;

  if not Result then
  begin
    ErroOutput.Exibir('Código é obrigatório');
    LojaIdEdit.SetFocus;
    exit;
  end;

  Result := FPessLojaEnt.State <> dsInsert;
  if Result then
    exit;

  Result := not FPessLojaDBI.LojaIdExiste(iLojaId, sApelido);

  if not Result then
  begin
    ErroOutput.Exibir('Código já é usado na loja '+sApelido);
    LojaIdEdit.SetFocus;
    exit;
  end;
end;

function TPessLojaEdForm.NomeFantasiaOk: boolean;
begin
  NomeFantaPessEdit.Text := Trim(NomeFantaPessEdit.Text);
  Result := NomeFantaPessEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir('Nome Fantasia é obrigatório');
  NomeFantaPessEdit.SetFocus
end;

procedure TPessLojaEdForm.ShowTimer_BasFormTimer(Sender: TObject);
//var
//  s: string;
begin
  inherited;
//{$IFDEF DEBUG}
  //SetTabOrderToHint(Self);
//{$ENDIF}

  DtNascPessLabel.Visible := False;
  DtNascDateTimePicker.Visible := False;

  AtivoPessCheckBox.Left := EMailPessEdit.Left + 5 + EMailPessEdit.Width;
  SelecionadoCheckBox.Left := AtivoPessCheckBox.Left + 5 + AtivoPessCheckBox.Width;
  LojaIdLabel.Left := SelecionadoCheckBox.Left + 7 + SelecionadoCheckBox.Width;
  LojaIdEdit.Left := LojaIdLabel.Left + 5 + LojaIdLabel.Width;

//{$IFDEF DEBUG}
////  s := CNPJGetRandom;
//  DebugImporteTeclas;
//{$ENDIF}
end;

end.
