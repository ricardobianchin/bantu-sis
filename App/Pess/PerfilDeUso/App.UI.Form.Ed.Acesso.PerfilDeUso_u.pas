unit App.UI.Form.Ed.Acesso.PerfilDeUso_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Acesso.PerfilDeUso.Ent,
  App.Acesso.PerfilDeUso.Ent.Factory_u, App.AppObj, App.Ent.Ed, App.Ent.DBI;

type
  TPerfilDeUsoEdForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FPerfilDeUsoEnt: IPerfilDeUsoEnt;
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
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PerfilDeUsoEdForm: TPerfilDeUsoEdForm;

implementation

{$R *.dfm}

uses Data.DB, Sis.UI.Controls.TLabeledEdit, Sis.Types.Integers;

procedure TPerfilDeUsoEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sVal: string;
begin
  inherited;
  LabeledEdit1.EditLabel.Caption := FPerfilDeUsoEnt.DescrCaption;

  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sFormat := 'Alterando %s: %s';
        sNom := FPerfilDeUsoEnt.NomeEnt;
        sVal := FPerfilDeUsoEnt.Descr;
        sCaption := Format(sFormat, [sNom, sVal]);
        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;
end;

function TPerfilDeUsoEdForm.ControlesOk: boolean;
begin
  Result := TesteLabeledEditVazio(LabeledEdit1, ErroOutput);
  if not Result then
    exit;

  Result := TesteLabeledEditValorInalterado(LabeledEdit1, FPerfilDeUsoEnt.Descr,
    FPerfilDeUsoEnt.State, ErroOutput);
  if not Result then
    exit;

end;

procedure TPerfilDeUsoEdForm.ControlesToEnt;
begin
  inherited;
  FPerfilDeUsoEnt.Descr := LabeledEdit1.Text;
end;

constructor TPerfilDeUsoEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
  FPerfilDeUsoEnt :=EntEdCastToPerfilDeUsoEnt(pEntEd);
end;

function TPerfilDeUsoEdForm.DadosOk: boolean;
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

procedure TPerfilDeUsoEdForm.EntToControles;
begin
  inherited;
  LabeledEdit1.Text := FPerfilDeUsoEnt.Descr;
end;

function TPerfilDeUsoEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := FPerfilDeUsoEnt.NomeEnt;
  sVal := FPerfilDeUsoEnt.Descr;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TPerfilDeUsoEdForm.GravouOk: boolean;
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

procedure TPerfilDeUsoEdForm.LabeledEdit1Change(Sender: TObject);
begin
  inherited;
  MensLimpar;

end;

procedure TPerfilDeUsoEdForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
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

procedure TPerfilDeUsoEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  LabeledEdit1.SetFocus;

end;

end.
