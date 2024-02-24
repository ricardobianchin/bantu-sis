unit App.UI.Form.Ed.Prod.Unid_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  App.Retag.Est.Prod.Unid.Ent, Data.DB;

type
  TProdUnidEdForm = class(TEdBasForm)
    DescrLabeledEdit: TLabeledEdit;
    SiglaLabeledEdit: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);

    procedure DescrLabeledEditChange(Sender: TObject);
    procedure DescrLabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure SiglaLabeledEditChange(Sender: TObject);
    procedure SiglaLabeledEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function GetProdUnidEnt: IProdUnidEnt;
    property ProdUnidEnt: IProdUnidEnt read GetProdUnidEnt;
    function GetAlterado: boolean;
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
  ProdUnidEdForm: TProdUnidEdForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Prod.Unid.Ent_u, Sis.UI.Controls.TLabeledEdit;

procedure TProdUnidEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sDes, sSig: string;
begin
  inherited;
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sNom := ProdUnidEnt.NomeEnt;
        sDes := ProdUnidEnt.Descr;
        sSig := ProdUnidEnt.Sigla;

        sFormat := 'Alterando %s: %s %s';
        sCaption := Format(sFormat, [sNom, sDes, sSig]);

        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;
end;

function TProdUnidEdForm.ControlesOk: boolean;
begin
  Result := TesteLabeledEditVazio(DescrLabeledEdit, ErroOutput);
  if not Result then
    exit;

  Result := TesteLabeledEditVazio(SiglaLabeledEdit, ErroOutput);
  if not Result then
    exit;

  Result := GetAlterado;
  if not Result then
    exit;
end;

procedure TProdUnidEdForm.ControlesToEnt;
begin
  inherited;
  ProdUnidEnt.Descr := DescrLabeledEdit.Text;
  ProdUnidEnt.Sigla := SiglaLabeledEdit.Text;
end;

function TProdUnidEdForm.DadosOk: boolean;
var
  sId: string;
  sIdAtual: string;
  sFrase: string;
begin
  Result := ProdUnidEnt.State in [dsEdit, dsInsert];
  if not Result then
  begin
    sFrase := 'O Status da janela não permite a gravação';
    ErroOutput.Exibir(sFrase);
    DescrLabeledEdit.SetFocus;
    exit;
  end;

  // if ProdUnidEnt.State = dsEdit then
  // begin

  sId := VarToStr(EntDBI.GetExistente(VarArrayOf([DescrLabeledEdit.Text,
    SiglaLabeledEdit.Text]), sFrase));

//  if ProdUnidEnt.State = dsInsert then
//  begin
    Result := sId = '';
    if not Result then
    begin
      ErroOutput.Exibir(sFrase);
      DescrLabeledEdit.SetFocus;
      exit;
    end;
//    exit;
//  end;
//
//  sIdAtual := '/'+ProdUnidEnt.Id.ToString+'/';
//  Result := Pos(sIdAtual, sId) > 0;
//  if not Result then
//  begin
//    ErroOutput.Exibir('Já existente ' + sFrase);
//    DescrLabeledEdit.SetFocus;
//    exit;
//  end;
end;

procedure TProdUnidEdForm.EntToControles;
begin
  inherited;
  DescrLabeledEdit.Text := ProdUnidEnt.Descr;
  SiglaLabeledEdit.Text := ProdUnidEnt.Sigla;
end;

function TProdUnidEdForm.GetAlterado: boolean;
var
  sDig, sOrig: string;
begin
  sOrig := ProdUnidEnt.Descr + ';' + ProdUnidEnt.Sigla;
  sDig := DescrLabeledEdit.Text + ';' + SiglaLabeledEdit.Text;

  Result := sOrig <> sDig;

  if not Result then
  begin
    ErroOutput.Exibir('Dados iguais ao registro já existente');
    DescrLabeledEdit.SetFocus;
  end;
end;

function TProdUnidEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sDes, sSig: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := ProdUnidEnt.NomeEnt;
  sDes := ProdUnidEnt.Descr;
  sSig := ProdUnidEnt.Sigla;

  sFormat := '%s %s: %s %s';
  Result := Format(sFormat, [sTit, sNom, sDes, sSig]);
end;

function TProdUnidEdForm.GetProdUnidEnt: IProdUnidEnt;
begin
  Result := TProdUnidEnt(EntEd);
end;

function TProdUnidEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.GarantirReg;
  if not Result then
  begin
    sFrase := 'Erro ao gravar ' + EntEd.NomeEnt;
    ErroOutput.Exibir(sFrase);
    DescrLabeledEdit.SetFocus;
    exit;
  end;
end;

procedure TProdUnidEdForm.DescrLabeledEditChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TProdUnidEdForm.DescrLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SiglaLabeledEdit.SetFocus;
    exit;
  end;
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TProdUnidEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  DescrLabeledEdit.SetFocus;
end;

procedure TProdUnidEdForm.SiglaLabeledEditChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TProdUnidEdForm.SiglaLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
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

end.
