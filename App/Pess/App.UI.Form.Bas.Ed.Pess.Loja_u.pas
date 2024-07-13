unit App.UI.Form.Bas.Ed.Pess.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed.Pess_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Pess.Ent.Factory_u, App.Pess.Loja.DBI,
  App.Pess.Loja.Ent, App.AppInfo, App.Ent.Ed, App.Ent.DBI, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TPessLojaEdForm = class(TPessEdBasForm)
    AtivoCheckBox: TCheckBox;
    LojaIdEdit: TEdit;
    LojaIdLabel: TLabel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
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
  Sis.Types.Integers;

procedure TPessLojaEdForm.AjusteTabOrder;
var
  iTabOrder: integer;
begin
  inherited;
  iTabOrder := DtNascDateTimePicker.TabOrder + 1;
  AtivoCheckBox.TabOrder := iTabOrder; Inc(iTabOrder);
  LojaIdEdit.TabOrder := iTabOrder;
end;

procedure TPessLojaEdForm.AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  CheckBoxKeyPress(Sender, Key);
end;

procedure TPessLojaEdForm.ControlesToEnt;
begin
  inherited;
  FPessLojaEnt.Ativo := AtivoCheckBox.Checked;
  FPessLojaEnt.LojaId := StrToInt(LojaIdEdit.Text);
end;

constructor TPessLojaEdForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  FPessLojaEnt := EntEdCastToPessLojaEnt(pEntEd);
  FPessLojaDBI := EntDBICastToPessLojaDBI(pEntDBI);
  inherited Create(AOwner, pAppInfo, pEntEd, pEntDBI);
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
  AtivoCheckBox.Checked := FPessLojaEnt.Ativo;
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

procedure TPessLojaEdForm.ShowTimer_BasFormTimer(Sender: TObject);
//var
//  s: string;
begin
  inherited;
  SetTabOrderToHint(Self);
  DtNascPessLabel.Visible := False;
  DtNascDateTimePicker.Visible := False;
  AtivoCheckBox.Left := DtNascPessLabel.Left;
  LojaIdLabel.Left := AtivoCheckBox.Left + 3 + AtivoCheckBox.Width;
  LojaIdEdit.Left := LojaIdLabel.Left + 3 + LojaIdLabel.Width;

//{$IFDEF DEBUG}
////  s := CNPJGetRandom;
//  DebugImporteTeclas;
//{$ENDIF}
end;

end.
