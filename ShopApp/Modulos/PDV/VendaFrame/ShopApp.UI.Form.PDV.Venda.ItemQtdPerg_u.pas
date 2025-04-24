unit ShopApp.UI.Form.PDV.Venda.ItemQtdPerg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, CustomEditBtu, CustomNumEditBtu, NumEditBtu,
  ShopApp.PDV.Venda.Engat_u, Sis.UI.Controls.Utils;

type
  TItemQtdPergForm = class(TDiagBtnBasForm)
    ProdLabel: TLabel;
    QtdNumEditBtu: TNumEditBtu;
    PrecoNumEditBtu: TNumEditBtu;
    PrecoUnitNumEditBtu: TNumEditBtu;
    procedure QtdNumEditBtuChange(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure QtdNumEditBtuKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FExigeBalanca: Boolean;
    procedure CalculePreco;
  protected
      function PodeOk: Boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pExigeBalanca: Boolean); reintroduce;

  end;

function ItemQtdPerg(var pEngat: TVendaProdEngat): Boolean;

var
  ItemQtdPergForm: TItemQtdPergForm;

implementation

{$R *.dfm}

uses System.Math, ShopApp.PDV.Venda.Utils_u;

function ItemQtdPerg(var pEngat: TVendaProdEngat): Boolean;
begin
  ItemQtdPergForm := TItemQtdPergForm.Create(Nil, pEngat.BalancaExige);
  try
    ItemQtdPergForm.ProdLabel.Caption := pEngat.GetText;
    ItemQtdPergForm.PrecoUnitNumEditBtu.Valor := pEngat.PrecoUnit;
    ItemQtdPergForm.QtdNumEditBtu.Valor := pEngat.Qtd;
    Result := ItemQtdPergForm.Perg;

    if not Result then
      exit;

    pEngat.Qtd := ItemQtdPergForm.QtdNumEditBtu.AsCurrency;
  finally
    ItemQtdPergForm.Free;
  end;
end;

{ TItemQtdPergForm }

procedure TItemQtdPergForm.CalculePreco;
var
  PU, Q, NovoPreco: Currency;
begin
  PU := PrecoUnitNumEditBtu.AsCurrency;
  Q := QtdNumEditBtu.AsCurrency;
  NovoPreco := RoundTo(PU * Q, -2);
  PrecoNumEditBtu.Valor := NovoPreco
end;

constructor TItemQtdPergForm.Create(AOwner: TComponent; pExigeBalanca: Boolean);
begin
  inherited Create(AOwner);
  FExigeBalanca := pExigeBalanca;
  ReadOnlySet(PrecoUnitNumEditBtu);
  ReadOnlySet(PrecoNumEditBtu);
end;

function TItemQtdPergForm.PodeOk: Boolean;
var
  uQtd: Currency;
  sMens: String;
begin
  uQtd := QtdNumEditBtu.AsCurrency;

  Result := ItemQtdValida(uQtd, FExigeBalanca, sMens);
  if not Result then
  begin
    ErroOutput.Exibir(sMens);
    QtdNumEditBtu.SetFocus;
  end;
end;

procedure TItemQtdPergForm.QtdNumEditBtuChange(Sender: TObject);
begin
  inherited;
  ErroOutput.Exibir('');
  CalculePreco;
end;

procedure TItemQtdPergForm.QtdNumEditBtuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
    OkAct_Diag.Execute;
end;

procedure TItemQtdPergForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  QtdNumEditBtu.SetFocus;
end;

end.
