unit App.UI.Form.Ed.Prod.ICMS_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, NumEditBtu,
  App.Retag.Est.Prod.ICMS.Ent, Data.DB, App.Ent.Ed, App.Ent.DBI, App.AppObj;

type
  TProdICMSEdForm = class(TEdBasForm)
    AtivoCheckBox: TCheckBox;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FPercNumEdit: TNumEditBtu;
    procedure PercNumEditChange(Sender: TObject);
    procedure PercNumEditKeyPress(Sender: TObject; var Key: Char);

    function GetProdICMSEnt: IProdICMSEnt;
    property ProdICMSEnt: IProdICMSEnt read GetProdICMSEnt;
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
  ProdICMSEdForm: TProdICMSEdForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Prod.ICMS.Ent_u, Sis.UI.Controls.TLabeledEdit,
  Sis.Types.Utils_u, Sis.Types.Integers, Sis.Types.Variants;

{ TProdICMSEdForm }

procedure TProdICMSEdForm.AjusteControles;
begin
  inherited;
end;

procedure TProdICMSEdForm.AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
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

function TProdICMSEdForm.ControlesOk: boolean;
var
  cPerc: currency;
begin
  cPerc := FPercNumEdit.AsCurrency;
  Result := cPerc > ZERO_CURRENCY;
  if not Result then
  begin
    FPercNumEdit.SetFocus;
    ErroOutput.Exibir('Percentual é obrigatório');
    exit;
  end;
end;

procedure TProdICMSEdForm.ControlesToEnt;
var
  cPerc: currency;
begin
  inherited;
  cPerc := FPercNumEdit.AsCurrency;
  ProdICMSEnt.Perc := cPerc;
  ProdICMSEnt.Ativo := AtivoCheckBox.Checked;
end;

constructor TProdICMSEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
  FPercNumEdit := TNumEditBtu.Create(Self);
  FPercNumEdit.Parent := Self;
  FPercNumEdit.NCasas:=5;
  FPercNumEdit.NCasasEsq:=2;

  FPercNumEdit.Caption := 'Percentual';

  FPercNumEdit.OnKeyPress := PercNumEditKeyPress;
  FPercNumEdit.OnChange := PercNumEditChange;

  FPercNumEdit.Left := ObjetivoLabel.Left + FPercNumEdit.EditLabel.Width;
  FPercNumEdit.Top := ObjetivoLabel.Top + Round(ObjetivoLabel.Height * 2.5);

  AtivoCheckBox.Top := FPercNumEdit.Top + 2;
  AtivoCheckBox.Left := FPercNumEdit.Left + FPercNumEdit.Width  + 12;

end;

function TProdICMSEdForm.DadosOk: boolean;
var
  iId: smallint;
  sFrase: string;
  aValores: variant;
begin
  Result := inherited DadosOk;
  if not Result then
    exit;

  // if ProdICMSEnt.State = dsEdit then
  // begin
  aValores := VarToVarArray(FPercNumEdit.Valor);

  iId := VarToInteger(EntDBI.GetRegsJaExistentes(aValores, sFrase));

  Result := iId = 0;
  if not Result then
  begin
    ErroOutput.Exibir(sFrase);
    FPercNumEdit.SetFocus;
    exit;
  end;
end;

procedure TProdICMSEdForm.EntToControles;
begin
  inherited;
  FPercNumEdit.Valor := ProdICMSEnt.Perc;
  AtivoCheckBox.Checked := ProdICMSEnt.Ativo;
end;

function TProdICMSEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sDes, sSig: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := ProdICMSEnt.NomeEnt;

  sFormat := '%s %s:';
  Result := Format(sFormat, [sTit, sNom]);
end;

function TProdICMSEdForm.GetProdICMSEnt: IProdICMSEnt;
begin
  Result := TProdICMSEnt(EntEd);
end;

function TProdICMSEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.Garantir;
  if not Result then
  begin
    sFrase := 'Erro ao gravar ' + EntEd.NomeEnt;
    ErroOutput.Exibir(sFrase);
    FPercNumEdit.SetFocus;
    exit;
  end;
end;

procedure TProdICMSEdForm.PercNumEditChange(Sender: TObject);
begin
  MensLimpar;
end;

procedure TProdICMSEdForm.PercNumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    AtivoCheckBox.SetFocus;
    exit;
  end;
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TProdICMSEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  FPercNumEdit.SetFocus;
end;

end.
