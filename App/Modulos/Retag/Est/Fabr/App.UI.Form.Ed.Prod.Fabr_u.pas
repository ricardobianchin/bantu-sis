unit App.UI.Form.Ed.Prod.Fabr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  App.Retag.Est.Prod.Fabr.Ent, Data.DB;

type
  TProdFabrEdForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function GetProdFabrEnt: IProdFabrEnt;
    property ProdFabrEnt: IProdFabrEnt read GetProdFabrEnt;
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
  ProdFabrEdForm: TProdFabrEdForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, App.Retag.Est.Prod.Fabr.Ent_u, Sis.Types.Integers,
  Sis.UI.Controls.TLabeledEdit;
{ TProdFabrEdForm }

procedure TProdFabrEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sVal: string;
begin
  inherited;
  LabeledEdit1.EditLabel.Caption := ProdFabrEnt.DescrCaption;

  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sFormat := 'Alterando %s: %s';
        sNom := ProdFabrEnt.NomeEnt;
        sVal := ProdFabrEnt.Descr;
        sCaption := Format(sFormat, [sNom, sVal]);
        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;
end;

function TProdFabrEdForm.ControlesOk: boolean;
begin
  Result := TesteLabeledEditVazio(LabeledEdit1, ErroOutput);
  if not Result then
    exit;

  Result := TesteLabeledEditValorInalterado(LabeledEdit1, ProdFabrEnt.Descr,
    ProdFabrEnt.State, ErroOutput);
  if not Result then
    exit;
end;

procedure TProdFabrEdForm.ControlesToEnt;
begin
  inherited;
  ProdFabrEnt.Descr := LabeledEdit1.Text;
end;

function TProdFabrEdForm.DadosOk: boolean;
var
  sFrase: string;
  sNomeCampo: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
  sRetorno: string;
begin
  sValorDigitado := LabeledEdit1.Text;
  sNomeCampo := LabeledEdit1.EditLabel.Caption;

  Result := ProdFabrEnt.State in [dsEdit, dsInsert];
  if not Result then
  begin
    sFrase := 'O Status da janela não permite a gravação';
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;

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

procedure TProdFabrEdForm.EntToControles;
begin
  inherited;
  LabeledEdit1.Text := ProdFabrEnt.Descr;
end;

function TProdFabrEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := ProdFabrEnt.NomeEnt;
  sVal := ProdFabrEnt.Descr;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TProdFabrEdForm.GetProdFabrEnt: IProdFabrEnt;
begin
  Result := TProdFabrEnt(EntEd);
end;

function TProdFabrEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.GarantirReg;
  if not Result then
  begin
    sFrase := 'Erro ao gravar ' + EntEd.NomeEnt;
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TProdFabrEdForm.LabeledEdit1Change(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TProdFabrEdForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
    exit;
  end;
  inherited;
  EditKeyPress(Sender, Key);

end;

procedure TProdFabrEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  LabeledEdit1.SetFocus;
end;

end.
