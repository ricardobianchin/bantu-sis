unit App.UI.Form.Ed.Retag.Prod.Fabr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed.Descr_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons, App.Retag.Est.Prod.Fabr, Data.DB, App.Retag.Est.Prod.Fabr.DBI;

type
  TProdFabrEdForm = class(TEdDescrBasForm)
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FProdFabr: IProdFabr;
    FProdFabrDBI: IProdFabrDBI;
    function DescrOk: boolean;
  protected
    function PodeOk: boolean; override;
    procedure AjustarControles; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pTitulo: string;
      pState: TDataSetState; pProdFabr: IProdFabr; pProdFabrDBI: IProdFabrDBI);
  end;

var
  ProdFabrEdForm: TProdFabrEdForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u;

{ TProdFabrEdForm }

procedure TProdFabrEdForm.AjustarControles;
begin
  inherited AjustarControles;
  LabeledEdit1.EditLabel.Caption := 'Nome';
end;

constructor TProdFabrEdForm.Create(AOwner: TComponent; pTitulo: string;
  pState: TDataSetState; pProdFabr: IProdFabr; pProdFabrDBI: IProdFabrDBI);
begin
  inherited Create(AOwner, pTitulo, pState);
  FProdFabr := pProdFabr;
  FProdFabrDBI := pProdFabrDBI;
end;

function TProdFabrEdForm.DescrOk: boolean;
var
  sFrase: string;
  sNomeCampo: string;
begin
  LabeledEdit1.Text := Trim(LabeledEdit1.Text);

  Result := LabeledEdit1.Text <> '';
  if not Result then
  begin
    sNomeCampo := LabeledEdit1.EditLabel.Caption;
    sFrase := Format('Campo ''%s'' é obrigatório', [sNomeCampo]);
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
  EditKeyPress(Sender, Key);
end;

function TProdFabrEdForm.PodeOk: boolean;
begin
  Result := inherited PodeOk;
  if not Result then
    exit;

  Result := DescrOk;
  if not Result then
    exit;

end;

end.
