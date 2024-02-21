unit App.UI.Form.Ed.Prod.Tipo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  App.Retag.Est.Prod.Tipo.Ent, Data.DB;

type
  TProdTipoEdForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function GetProdTipoEnt: IProdTipoEnt;
    property ProdTipoEnt: IProdTipoEnt read GetProdTipoEnt;
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
  ProdTipoEdForm: TProdTipoEdForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, App.Retag.Est.Prod.Tipo.Ent_u;
{ TProdTipoEdForm }

procedure TProdTipoEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sVal: string;
begin
  inherited;
  LabeledEdit1.EditLabel.Caption := ProdTipoEnt.DescrCaption;

  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sFormat := 'Alterando %s: %s';
        sNom := ProdTipoEnt.NomeEnt;
        sVal := ProdTipoEnt.Descr;
        sCaption := Format(sFormat, [sNom, sVal]);
        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;
end;

function TProdTipoEdForm.ControlesOk: boolean;
var
  sFrase: string;
  sNomeCampo: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
begin
  LabeledEdit1.Text := StrSemCharRepetido(LabeledEdit1.Text, #32);
  sValorDigitado := LabeledEdit1.Text;
  sNomeCampo := LabeledEdit1.EditLabel.Caption;

  Result := sValorDigitado <> '';
  if not Result then
  begin
    sFormat := 'Campo ''%s'' é obrigatório';
    sFrase := Format(sFormat, [sNomeCampo]);
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TProdTipoEdForm.ControlesToEnt;
begin
  inherited;
  ProdTipoEnt.Descr := LabeledEdit1.Text;
end;

function TProdTipoEdForm.DadosOk: boolean;
var
  sFrase: string;
  sNomeCampo: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
begin
  sValorDigitado := LabeledEdit1.Text;
  sNomeCampo := LabeledEdit1.EditLabel.Caption;

  Result := ProdTipoEnt.State in [dsEdit, dsInsert];
  if not Result then
  begin
    sFrase := 'O Status da janela não permite a gravação';
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;

  if ProdTipoEnt.State = dsEdit then
  begin
    Result := sValorDigitado <> ProdTipoEnt.Descr;

    if not Result then
    begin
      sFormat := 'Campo %s igual ao já existente';
      sFrase := Format(sFormat, [sNomeCampo]);
      ErroOutput.Exibir(sFrase);
      LabeledEdit1.SetFocus;
      exit;
    end;
  end;

  iId := EntDBI.GetExistente(sValorDigitado);
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

procedure TProdTipoEdForm.EntToControles;
begin
  inherited;
  LabeledEdit1.Text := ProdTipoEnt.Descr;
end;

function TProdTipoEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
begin
  sFormat := '%s %s: %s';
  sTit := EntEd.StateAsTitulo;
  sNom := ProdTipoEnt.NomeEnt;
  sVal := ProdTipoEnt.Descr;
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TProdTipoEdForm.GetProdTipoEnt: IProdTipoEnt;
begin
  Result := TProdTipoEnt(EntEd);
end;

function TProdTipoEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.GarantirReg;
  if not Result then
  begin
    sFrase := 'Erro ao gravar '+EntEd.NomeEnt;
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TProdTipoEdForm.LabeledEdit1Change(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TProdTipoEdForm.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
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

procedure TProdTipoEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  LabeledEdit1.SetFocus;
end;

end.
