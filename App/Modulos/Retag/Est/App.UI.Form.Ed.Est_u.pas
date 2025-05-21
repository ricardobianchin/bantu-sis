unit App.UI.Form.Ed.Est_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.ProdSelectFrame_u, Sis.DB.DBTypes, CustomEditBtu,
  CustomNumEditBtu, NumEditBtu, Data.DB, App.Est.EstMovEnt, App.Est.EstMovItem,
  App.Est.EstMovDBI;

type
  TEstEdBasForm = class(TEdBasForm)
    NotaGroupBox: TGroupBox;
    CodLabeledEdit: TLabeledEdit;
    ItemGroupBox: TGroupBox;
    QtdNumEditBtu: TNumEditBtu;
    procedure OkAct_DiagExecute(Sender: TObject);
  private
    { Private declarations }
    FProdSelectFrame: TProdSelectFrame;
    FEstMovEnt: IEstMovEnt<IEstMovItem>;
    FEstMovDBI: IEstMovDBI;
  protected
    function ControlesOk: boolean; override;

    procedure AjusteControles; override;
    procedure AjusteTabOrder; virtual; abstract;
    procedure ProdSelectProdLabeledEditKeyPress(Sender: TObject; var Key: Char);
      virtual; abstract;
    procedure ProdSelectSelect(Sender: TObject); virtual;
    function GetObjetivoStr: string; override;
    property ProdSelectFrame: TProdSelectFrame read FProdSelectFrame;
    function GravouOk: boolean; override;

  public
    { Public declarations }

    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pDBConnection: IDBConnection); reintroduce; virtual;
  end;

var
  EstEdBasForm: TEstEdBasForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.Types.Floats;

{ TEstEdBasForm }

procedure TEstEdBasForm.AjusteControles;
begin
  inherited;
  ReadOnlySet(CodLabeledEdit);
  AjusteTabOrder;
  ItemGroupBox.Caption := FEstMovEnt.NomeEnt;
  if FEstMovEnt.State = dsEdit then
  begin
    ItemGroupBox.Visible := False;
    Height := Height - ItemGroupBox.Height;
  end;
end;

function TEstEdBasForm.ControlesOk: boolean;
var
  s: string;
begin
  Result := FEstMovEnt.State = dsEdit;
  if Result then
    Exit;

  Result := ProdSelectFrame.ProdId > 0;
  if not Result then
  begin
    ErroOutput.Exibir('O Produto é obrigatório');
    ProdSelectFrame.ProdLabeledEdit.SetFocus;
    exit;
  end;

  Result := QtdNumEditBtu.Valor > 0;
  if not Result then
  begin
    ErroOutput.Exibir('A Quantidade é obrigatória');
    QtdNumEditBtu.SetFocus;
    exit;
  end;

  Result := ProdSelectFrame.ProdBalancaExige;
  if Result then
    exit;

  Result := CurrencyEhInteiro(QtdNumEditBtu.Valor);
  if not Result then
  begin
    s := 'Produto não é de balança. A quantidade deve ser inteira';
    ErroOutput.Exibir(s);
    QtdNumEditBtu.SetFocus;
    exit;
  end;
end;

constructor TEstEdBasForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  FEstMovDBI := pEntDBI as IEstMovDBI;
  FEstMovEnt := pEntEd as IEstMovEnt<IEstMovItem>;
  // FEstMovEnt: IEstMovEnt<IEstMovItem>;pEntEd as IEstSaidaEnt

  FProdSelectFrame := TProdSelectFrame.Create(ItemGroupBox,
    pDBConnection, pAppObj);

  FProdSelectFrame.ProdLabeledEdit.OnKeyPress :=
    ProdSelectProdLabeledEditKeyPress;
  FProdSelectFrame.OnSelect := ProdSelectSelect;

  FProdSelectFrame.Left := 10;
  FProdSelectFrame.Top := 20;
  QtdNumEditBtu.Left := FProdSelectFrame.Left + FProdSelectFrame.Width + 4 +
    QtdNumEditBtu.EditLabel.Width + QtdNumEditBtu.LabelSpacing;
  QtdNumEditBtu.Top := FProdSelectFrame.Top;

  CodLabeledEdit.TabStop := False;
  Sis.UI.Controls.Utils.ReadOnlySet(CodLabeledEdit, True);
  // CodLabeledEdit.Color := $00D3D7B9;
end;

function TEstEdBasForm.GetObjetivoStr: string;
begin
  if FEstMovEnt.EditandoItem then
  begin
    Result := 'Novo item de '+FEstMovEnt.NomeEnt;
  end
  else
  begin
    Result := 'Nova nota de '+FEstMovEnt.NomeEnt;
  end;
end;

function TEstEdBasForm.GravouOk: boolean;
begin
  Result := FEstMovDBI.Gravar;
end;

procedure TEstEdBasForm.OkAct_DiagExecute(Sender: TObject);
begin
  inherited;
  FEstMovEnt.EditandoItem := True;

end;

procedure TEstEdBasForm.ProdSelectSelect(Sender: TObject);
begin
  MensLimpar;
  QtdNumEditBtu.setFocus;
end;

end.
