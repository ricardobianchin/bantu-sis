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
    ObjetivoLabel: TLabel;
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FProdFabr: IProdFabr;
    FProdFabrOriginal: IProdFabr;
    FProdFabrDBI: IProdFabrDBI;
    function DescrOk: boolean;
    function GravouOk: boolean;
    procedure ControlesToEnt;
    procedure EntToControles;
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

uses Sis.Types.strings_u, App.DB.Utils, App.Retag.Est.Prod.Fabr_u;

{ TProdFabrEdForm }

procedure TProdFabrEdForm.AjustarControles;
begin
  inherited AjustarControles;
  LabeledEdit1.EditLabel.Caption := 'Nome';

  Caption := 'Fabricante - '+DataSetStateToTitulo(State);
  case State of
    dsInactive: ;
    dsBrowse: ;
    dsEdit:
    begin
      FProdFabrOriginal := TProdFabr.Create(dsBrowse, FProdFabr.Id, FProdFabr.Descr);
      ObjetivoLabel.Caption := 'Alterando fabricante: '+FProdFabrOriginal.Descr;
      EntToControles;
    end;

    dsInsert:
    begin
      ObjetivoLabel.Caption := 'Novo fabricante';
    end;
  end;
end;

procedure TProdFabrEdForm.ControlesToEnt;
begin
  FProdFabr.Descr := LabeledEdit1.Text;
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
  iFabricanteId: smallint;
  sNomeDigitado: string;
begin
  LabeledEdit1.Text := Trim(LabeledEdit1.Text);
  sNomeDigitado := LabeledEdit1.Text;
  sNomeCampo := LabeledEdit1.EditLabel.Caption;

  Result := sNomeDigitado <> '';
  if not Result then
  begin
    sFrase := Format('Campo ''%s'' é obrigatório', [sNomeCampo]);
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;

  if State = dsEdit then
  begin
    Result := sNomeDigitado <> FProdFabrOriginal.Descr;

    if not Result then
    begin
      sFrase := 'Nome igual ao já existente';
      ErroOutput.Exibir(sFrase);
      LabeledEdit1.SetFocus;
      exit;
    end;
  end;

  iFabricanteId := FProdFabrDBI.ByNome(sNomeDigitado);
  Result := iFabricanteId < 1;
  if not Result then
  begin
    sFrase := Format('''%s'' já está cadastrado sob o código %d',
      [sNomeDigitado, iFabricanteId]);
    ErroOutput.Exibir(sFrase);
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

procedure TProdFabrEdForm.EntToControles;
begin
  LabeledEdit1.Text := FProdFabr.Descr;
end;

function TProdFabrEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := FProdFabrDBI.Garantir;
  if not Result then
  begin
    sFrase := 'Erro ao gravar Fabricante';
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
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
    exit;
  end;
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

  ControlesToEnt;

  Result := GravouOk;
  if not Result then
    exit;

end;

end.
