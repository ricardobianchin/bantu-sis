unit App.UI.Form.Bas.Ed.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, App.Ent.DBI, App.AppInfo, App.Pess.Ent,
  App.Pess.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, App.Pess.Ender.Frame_u,
  Vcl.ComCtrls;

type
  TPessEdBasForm = class(TEdBasForm)
    NomePessLabel: TLabel;
    NomePessEdit: TEdit;
    NomeFantaPessLabel: TLabel;
    NomeFantaPessEdit: TEdit;
    ApelidoPessLabel: TLabel;
    ApelidoPessEdit: TEdit;
    CPessLabel: TLabel;
    CPessEdit: TEdit;
    IPessLabel: TLabel;
    IPessEdit: TEdit;
    MPessLabel: TLabel;
    MPessEditEdit: TEdit;
    MUFPessLabel: TLabel;
    MUFPessEdit: TEdit;
    EMailPessLabel: TLabel;
    EMailPessEdit: TEdit;
    DtNascPessLabel: TLabel;
    DtNascDateTimePicker: TDateTimePicker;
    EnderecoPanel: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure NomePessEditKeyPress(Sender: TObject; var Key: Char);
    procedure NomeFantaPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure ApelidoPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure CPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure IPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure MPessEditEditKeyPress(Sender: TObject; var Key: Char);
    procedure MUFPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure EMailPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure DtNascDateTimePickerKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CPessEditExit(Sender: TObject);
    procedure CPessEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;

    FEnderFrame: TEnderFrame;

    function NomeOk: boolean;
    function NomeFantasiaOk: boolean;
    function ApelidoOk: boolean;
    function COk: boolean;
    procedure ColarC;

  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
    procedure AjusteTabOrder; virtual;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessEdBasForm: TPessEdBasForm;

implementation

{$R *.dfm}

uses App.Pess.Ent.Factory_u, Sis.UI.Controls.TLabeledEdit, Sis.Types.Dates,
  Sis.UI.Controls.Utils, Sis.Types.Codigos.Utils, Sis.DB.DBTypes, Sis.Types,
  Sis.Types.strings_u, Sis.Win.Utils_u, System.StrUtils;

procedure TPessEdBasForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sDes: string;
begin
  inherited;
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sNom := FPessEnt.NomeEnt;
        sDes := FPessEnt.Nome;

        sFormat := 'Alterando %s: %s';
        sCaption := Format(sFormat, [sNom, sDes]);
      end;

    dsInsert:
      ;
  end;
  FEnderFrame.AjusteControles;
  NomePessEdit.SetFocus;
  AjusteTabOrder;

  NomePessEdit.OnKeyPress := NomePessEditKeyPress;
  NomeFantaPessEdit.OnKeyPress := NomeFantaPessEditKeyPress;
  ApelidoPessEdit.OnKeyPress := ApelidoPessEditKeyPress;
  CPessEdit.OnKeyPress := CPessEditKeyPress;
  IPessEdit.OnKeyPress := IPessEditKeyPress;
  MPessEditEdit.OnKeyPress := MPessEditEditKeyPress;
  MUFPessEdit.OnKeyPress := MUFPessEditKeyPress;
  EMailPessEdit.OnKeyPress := EMailPessEditKeyPress;
  DtNascDateTimePicker.OnKeyPress := DtNascDateTimePickerKeyPress;
end;

procedure TPessEdBasForm.AjusteTabOrder;
begin
  NomePessEdit.TabOrder := 0;
  NomeFantaPessEdit.TabOrder := 1;
  ApelidoPessEdit.TabOrder := 2;
  CPessEdit.TabOrder := 3;
  IPessEdit.TabOrder := 4;
  MPessEditEdit.TabOrder := 5;
  MUFPessEdit.TabOrder := 6;
  EMailPessEdit.TabOrder := 7;
  DtNascDateTimePicker.TabOrder := 8;
end;

procedure TPessEdBasForm.ApelidoPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.Button1Click(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := CNPJGetRandom;
  CPessEdit.Text := s;
  IPessEdit.SetFocus;
  // function CPFGetRandom: string;
end;

procedure TPessEdBasForm.Button2Click(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := CPFGetRandom;
  CPessEdit.Text := s;
  IPessEdit.SetFocus;
end;

function TPessEdBasForm.COk: boolean;
var
  sMens: string;
  iLojaId, iTerminalId: smallint;
  iPessoaId: integer;
  sNome: string;
begin
  CPessEdit.Text := Trim(CPessEdit.Text);

  try
    if CPessEdit.Text = '' then
    begin
      Result := not FPessEnt.CObrigatorio;
      if Result then
        exit;

      sMens := CPessLabel.Caption + ' é obrigatório';
    end
    else
    begin
      Result := Sis.Types.Codigos.Utils.CValido(CPessEdit.Text);
      if Result then
        exit;
      sMens := CPessLabel.Caption + ' inválido';
      if not FPessEnt.CObrigatorio then
        sMens := sMens + '. Corrija o campo ou deixe-o vazio';

      Result := not FPessDBI.CToIdLojaTermRecord(CPessEdit.Text, iLojaId,
        iTerminalId, iPessoaId, sNome);
      if not Result then
        sMens := 'Já existe um registro com este ' + string(CPessLabel.Caption) +
          CodsToCodAsString(iLojaId, iTerminalId, iPessoaId,
          FPessEnt.CodUsaTerminalId) + ' ' + sNome;
    end;
  finally
    if not Result then
    begin
      ErroOutput.Exibir(sMens);
      CPessEdit.SetFocus;
    end;
  end;
end;

procedure TPessEdBasForm.ColarC;
var
  sText: string;
begin
  inherited;
  sText := GetClipboardText;
  sText := StrToOnlyDigit(sText);

  if sText = '' then
    exit;

  sText := LeftStr(sText, 8);
  CPessEdit.Text := sText;
end;

function TPessEdBasForm.ControlesOk: boolean;
begin
  Result := TesteEditVazio(NomePessEdit, 'Nome', ErroOutput);
  if not Result then
    exit;

end;

procedure TPessEdBasForm.ControlesToEnt;
begin
  inherited;
  FPessEnt.Nome := NomePessEdit.Text;
  FPessEnt.NomeFantasia := NomeFantaPessEdit.Text;
  FPessEnt.Apelido := ApelidoPessEdit.Text;
  FPessEnt.C := CPessEdit.Text;
  FPessEnt.I := IPessEdit.Text;
  FPessEnt.M := MPessEditEdit.Text;
  FPessEnt.MUF := MUFPessEdit.Text;
  FPessEnt.EMail := EMailPessEdit.Text;

  FPessEnt.DtNasc := DtNascDateTimePicker.Date;

  FEnderFrame.ControlesToEnt;
end;

procedure TPessEdBasForm.CPessEditExit(Sender: TObject);
begin
  inherited;
  CPessEdit.Text := StrToOnlyDigit(CPessEdit.Text);
end;

procedure TPessEdBasForm.CPessEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sText: string;
begin
  inherited;
  case Key of
    ord('v'), ord('V'):
      begin
        if Shift = [ssCtrl] then
        begin
          ColarC;
        end;
      end;
  end;
end;

procedure TPessEdBasForm.CPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
  if Key = #0 then
    exit;
end;

constructor TPessEdBasForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pAppInfo, pEntEd, pEntDBI);
  FPessEnt := EntEdCastToPessEnt(pEntEd);
  FPessDBI := EntDBICastToPessDBI(pEntDBI);

  FEnderFrame := TEnderFrame.Create(EnderecoPanel, FPessEnt, FPessDBI, pAppInfo,
    OkAct_DiagExecute, ErroOutput);

  DtNascDateTimePicker.Time := 0;
  DtNascDateTimePicker.Date := Date;

end;

function TPessEdBasForm.DadosOk: boolean;
begin
  Result := NomeOk;
  if not Result then
    exit;

  Result := NomeFantasiaOk;
  if not Result then
    exit;

  Result := ApelidoOk;
  if not Result then
    exit;

  Result := COk;
  if not Result then
    exit;

  Result := FEnderFrame.DadosOk;
end;

procedure TPessEdBasForm.DtNascDateTimePickerKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
  // FEnderFrame.FoqueOPrimeiro;
end;

procedure TPessEdBasForm.EMailPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.EntToControles;
begin
  inherited;
  NomePessEdit.Text := FPessEnt.Nome;
  NomeFantaPessEdit.Text := FPessEnt.NomeFantasia;
  ApelidoPessEdit.Text := FPessEnt.Apelido;
  CPessEdit.Text := FPessEnt.C;
  IPessEdit.Text := FPessEnt.I;
  MPessEditEdit.Text := FPessEnt.M;
  MUFPessEdit.Text := FPessEnt.MUF;
  EMailPessEdit.Text := FPessEnt.EMail;
  DtNascDateTimePicker.Date := GetValidDate(FPessEnt.DtNasc);

  FEnderFrame.EntToControles;
end;

procedure TPessEdBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  //
end;

procedure TPessEdBasForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  //
end;

function TPessEdBasForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := EntEd.NomeEnt;
  if EntEd.State = dsInsert then
    sVal := ''
  else
    sVal := FPessEnt.CodAsString;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TPessEdBasForm.GravouOk: boolean;
begin
  Result := EntDBI.Garantir;
end;

procedure TPessEdBasForm.IPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MPessEditEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MUFPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

function TPessEdBasForm.ApelidoOk: boolean;
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

procedure TPessEdBasForm.NomeFantaPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

function TPessEdBasForm.NomeFantasiaOk: boolean;
begin
  NomeFantaPessEdit.Text := Trim(NomeFantaPessEdit.Text);
  Result := NomeFantaPessEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir('Nome Fantasia é obrigatório');
  NomeFantaPessEdit.SetFocus
end;

function TPessEdBasForm.NomeOk: boolean;
begin
  NomePessEdit.Text := Trim(NomePessEdit.Text);
  Result := NomePessEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir('Nome é obrigatório');
  NomePessEdit.SetFocus
end;

procedure TPessEdBasForm.NomePessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
  if Key = #13 then
    NomeFantaPessEdit.SetFocus;
  // SelectNext(NomePessEdit,True, True);
end;

procedure TPessEdBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  NomePessEdit.SetFocus;
end;

end.
