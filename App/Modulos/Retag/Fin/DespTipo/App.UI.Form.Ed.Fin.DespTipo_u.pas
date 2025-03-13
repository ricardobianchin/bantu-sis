unit App.UI.Form.Ed.Fin.DespTipo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  App.Retag.Fin.DespTipo.Ent, App.Retag.Fin.Factory;

type
  TDespTipoEdForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function GetDespTipoEnt: IDespTipoEnt;
    property DespTipoEnt: IDespTipoEnt read GetDespTipoEnt;
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
  end;

var
  DespTipoEdForm: TDespTipoEdForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, App.Retag.Est.Prod.Fabr.Ent_u, Sis.Types.Integers,
  Sis.Types.Variants;

procedure TDespTipoEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sVal: string;
begin
  inherited;
  LabeledEdit1.EditLabel.Caption := DespTipoEnt.DescrCaption;

  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sFormat := 'Alterando %s: %s';
        sNom := DespTipoEnt.NomeEnt;
        sVal := DespTipoEnt.Descr;
        sCaption := Format(sFormat, [sNom, sVal]);
        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;
end;

function TDespTipoEdForm.ControlesOk: boolean;
begin
  Result := TesteLabeledEditVazio(LabeledEdit1, ErroOutput);
  if not Result then
    exit;

  Result := TesteLabeledEditValorInalterado(LabeledEdit1, DespTipoEnt.Descr,
    DespTipoEnt.State, ErroOutput);
  if not Result then
    exit;
end;

procedure TDespTipoEdForm.ControlesToEnt;
begin
  inherited;
  DespTipoEnt.Descr := LabeledEdit1.Text;
end;

function TDespTipoEdForm.DadosOk: boolean;
var
  sFrase: string;
  sNomeCampo: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
  sRetorno: string;
  aValores: variant;
  vRetorno: variant;
begin
  Result := inherited DadosOk;
  if not Result then
    exit;

  sValorDigitado := LabeledEdit1.Text;
  sNomeCampo := LabeledEdit1.EditLabel.Caption;

  aValores := VarToVarArray(sValorDigitado);

  vRetorno := EntDBI.GetRegsJaExistentes(aValores, sRetorno, Result);

  if not Result then
  begin
    iId := vRetorno[0];
    sFormat := '''%s'' já está cadastrado sob o código %d';
    sFrase := Format(sFormat, [sValorDigitado, iId]);
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TDespTipoEdForm.EntToControles;
begin
  inherited;
  LabeledEdit1.Text := DespTipoEnt.Descr;
end;

function TDespTipoEdForm.GetDespTipoEnt: IDespTipoEnt;
begin
cast
  Result := EntEdCastToDespTipoEnt(EntEd);
end;

function TDespTipoEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := DescTipoEnt.NomeEnt;
  sVal := DescTipoEnt.Descr;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TDespTipoEdForm.GravouOk: boolean;
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

procedure TDespTipoEdForm.LabeledEdit1Change(Sender: TObject);
begin
  inherited;
  MensLimpar;

end;

procedure TDespTipoEdForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
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

procedure TDespTipoEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  LabeledEdit1.SetFocus;
end;

end.
