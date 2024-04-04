unit App.UI.Form.Ed.Prod.Barras_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, App.Est.Prod.Barras.DBI;

type
  TProdBarrasEdForm = class(TDiagBtnBasForm)
    LabeledEdit1: TLabeledEdit;
    GeraBarrasLabel: TLabel;
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure GeraBarrasLabelClick(Sender: TObject);
  private
    { Private declarations }
    FListaAtualSL: TStringList;
    FBarrasDBI: IBarrasDBI;
    FProdIdEste: integer;
  protected
    function PodeOk: Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pListaCodBarras: string;
      pBarrasDBI: IBarrasDBI; pProdIdEste: integer); reintroduce;
  end;

var
  ProdBarrasEdForm: TProdBarrasEdForm;

implementation

{$R *.dfm}

uses Sis.Types.Codigos.Utils;

{ TProdBarrasEdForm }

constructor TProdBarrasEdForm.Create(AOwner: TComponent;
  pListaCodBarras: string; pBarrasDBI: IBarrasDBI; pProdIdEste: integer);
begin
  inherited Create(AOwner);
  FListaAtualSL := TStringList.Create;
  FListaAtualSL.Text := pListaCodBarras;
  FBarrasDBI := pBarrasDBI;
  FProdIdEste := pProdIdEste;
end;

procedure TProdBarrasEdForm.FormDestroy(Sender: TObject);
begin
  FListaAtualSL.Free;
  inherited;
end;

procedure TProdBarrasEdForm.GeraBarrasLabelClick(Sender: TObject);
begin
  inherited;
  LabeledEdit1.Text := EAN13GetRandom;
end;

procedure TProdBarrasEdForm.LabeledEdit1Change(Sender: TObject);
begin
  inherited;
  MensLabel.Visible := false;
end;

procedure TProdBarrasEdForm.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    OkAct_Diag.Execute;
end;

function TProdBarrasEdForm.PodeOk: Boolean;
var
  iIndex: integer;
  iProdIdOutro: integer;
  sBarras: string;
begin
  LabeledEdit1.Text := Trim(LabeledEdit1.Text);
  sBarras := LabeledEdit1.Text;

  Result := sBarras <> '';
  if not Result then
  begin
    ErroOutput.Exibir('Código de barras obrigatório');
    LabeledEdit1.SetFocus;
    exit;
  end;

  iIndex := FListaAtualSL.IndexOf(sBarras);
  Result := iIndex = -1;
  if not Result then
  begin
    ErroOutput.Exibir('Código de barras já está na lista');
    LabeledEdit1.SetFocus;
    exit;
  end;

  Result := BarCodValido(sBarras);
  if not Result then
  begin
    ErroOutput.Exibir('Código de barras inválido');
    LabeledEdit1.SetFocus;
    exit;
  end;

  iProdIdOutro := FBarrasDBI.CodBarrasToProdId(sBarras, FProdIdEste);
  Result := iProdIdOutro < 1;
  if not Result then
  begin
    ErroOutput.Exibir('Código de barras do Produto ' + iProdIdOutro.ToString);
    LabeledEdit1.SetFocus;
    exit;
  end;

end;

end.
