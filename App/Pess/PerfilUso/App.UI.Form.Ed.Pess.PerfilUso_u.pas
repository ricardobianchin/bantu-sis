unit App.UI.Form.Ed.Pess.PerfilUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Pess.PerfilUso.Ent,
  App.Pess.PerfilUso.Ent.Factory_u, App.AppInfo, App.Ent.Ed, App.Ent.DBI;

type
  TPerfilUsoEdForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FPerfilUsoEnt: IPerfilUsoEnt;
  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;
    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PerfilUsoEdForm: TPerfilUsoEdForm;

implementation

{$R *.dfm}

uses Data.DB, Sis.UI.Controls.TLabeledEdit, Sis.Types.Integers;

procedure TPerfilUsoEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sVal: string;
begin
  inherited;
  LabeledEdit1.EditLabel.Caption := FPerfilUsoEnt.DescrCaption;

  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sFormat := 'Alterando %s: %s';
        sNom := FPerfilUsoEnt.NomeEnt;
        sVal := FPerfilUsoEnt.Descr;
        sCaption := Format(sFormat, [sNom, sVal]);
        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;
end;

function TPerfilUsoEdForm.ControlesOk: boolean;
begin
  Result := TesteLabeledEditVazio(LabeledEdit1, ErroOutput);
  if not Result then
    exit;

  Result := TesteLabeledEditValorInalterado(LabeledEdit1, FPerfilUsoEnt.Descr,
    FPerfilUsoEnt.State, ErroOutput);
  if not Result then
    exit;

end;

procedure TPerfilUsoEdForm.ControlesToEnt;
begin
  inherited;
  FPerfilUsoEnt.Descr := LabeledEdit1.Text;
end;

constructor TPerfilUsoEdForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
  FPerfilUsoEnt :=EntEdCastToPerfilUsoEnt(pEntEd);
end;

function TPerfilUsoEdForm.DadosOk: boolean;
var
  sFrase: string;
  sNomeCampo: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
  sRetorno: string;
begin
  Result := inherited DadosOk;
  if not Result then
    exit;

  sValorDigitado := LabeledEdit1.Text;
  sNomeCampo := LabeledEdit1.EditLabel.Caption;

  iId := VarToInteger(EntDBI.GetExistente(sValorDigitado, sRetorno));

  Result := iId < 1;
  if not Result then
  begin
    sFormat := '''%s'' já está cadastrado sob o código %d';
    sFrase := Format(sFormat, [sValorDigitado, iId]);
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TPerfilUsoEdForm.EntToControles;
begin
  inherited;
  LabeledEdit1.Text := FPerfilUsoEnt.Descr;
end;

function TPerfilUsoEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := FPerfilUsoEnt.NomeEnt;
  sVal := FPerfilUsoEnt.Descr;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TPerfilUsoEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.Garantir;
  if not Result then
  begin
    sFrase := 'Erro ao gravar ' + EntEd.NomeEnt;
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TPerfilUsoEdForm.LabeledEdit1Change(Sender: TObject);
begin
  inherited;
  MensLimpar;

end;

procedure TPerfilUsoEdForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
    exit;
  end;
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPerfilUsoEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  LabeledEdit1.SetFocus;

end;

end.
