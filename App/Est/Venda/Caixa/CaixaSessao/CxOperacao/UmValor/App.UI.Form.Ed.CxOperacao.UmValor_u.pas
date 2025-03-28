unit App.UI.Form.Ed.CxOperacao.UmValor_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Ed.CxOperacao_u,
  App.Ent.Ed, App.Ent.DBI, App.AppObj,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  NumEditBtu, Vcl.ComCtrls, App.UI.Controls.NumerarioListFrame_u, Sis.Usuario,
  App.Est.Venda.Caixa.CxValor.DBI, App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  Vcl.Mask, CustomEditBtu, CustomNumEditBtu;

type
  TCxOperUmValorEdForm = class(TCxOperacaoEdForm)
    ObsLabel: TLabel;
    TrabPageControl: TPageControl;
    ValorTabSheet: TTabSheet;
    NumerarioTabSheet: TTabSheet;
    ValorNumEditBtu: TNumEditBtu;
    procedure TrabPageControlChange(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure ValorNumEditBtuKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FNumerarioListFrame: TNumerarioListFrame;
    function GetValorDoControle: Currency;
  protected
    procedure ControlesToEnt; override;
    procedure EntToControles; override;
    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pUsuarioId: integer; pUsuarioNomeExib: string; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI); reintroduce; virtual;
  end;

var
  CxOperUmValorEdForm: TCxOperUmValorEdForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, App.Est.Venda.CaixaSessao.Factory_u,
  Sis.Types.Utils_u, App.Est.Venda.Caixa.CaixaSessao.Utils_u;

{ TCxOperUmValorEdForm }

function TCxOperUmValorEdForm.ControlesOk: boolean;
begin
  Result := inherited ControlesOk;
  if not Result then
    exit;

  Result := CxOperacaoEnt.CxOperacaoTipo.Id = cxOpAbertura;

  if Result then
    exit;

  if TrabPageControl.ActivePage = ValorTabSheet then
  begin
    Result := ValorNumEditBtu.AsCurrency > ZERO_CURRENCY;
    if not Result then
    begin
      ErroOutput.Exibir('Valor é obrigatório');
      ValorNumEditBtu.SetFocus;
    end;
    exit;
  end;
end;

procedure TCxOperUmValorEdForm.ControlesToEnt;
begin
  inherited;
  if TrabPageControl.ActivePage = ValorTabSheet then
  begin
    CxOperacaoEnt.Valor := ValorNumEditBtu.AsCurrency;
    exit;
  end;
end;

constructor TCxOperUmValorEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pUsuarioId: integer; pUsuarioNomeExib: string; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI);
begin
  inherited Create(AOwner, pAppObj, pUsuarioId, pUsuarioNomeExib,
    pEntEd, pEntDBI);

  ValorNumEditBtu.EditLabel.StyleElements := ValorNumEditBtu.StyleElements;
  ValorNumEditBtu.EditLabel.Font.Assign(ValorNumEditBtu.Font);

  FNumerarioListFrame := TNumerarioListFrame.Create(NumerarioTabSheet,
    pCxValorDBI, AppObj.AppInfo.PastaImg + 'App\Numerario\Indiv\');

  NumerarioTabSheet.TabVisible := False;
end;

function TCxOperUmValorEdForm.DadosOk: boolean;
var
  iQtdValores: integer;
begin
  Result := inherited;
  if not Result then
    exit;

  iQtdValores := CxOperacaoEnt.CxValorList.Count;
  if iQtdValores = 0 then
  begin
    if TrabPageControl.ActivePage = ValorTabSheet then
    begin
      CxOperacaoEnt.CxValorList.PegueCxValor(1, ValorNumEditBtu.AsCurrency);
    end;
  end
  else
  begin
    if TrabPageControl.ActivePage = ValorTabSheet then
    begin
      CxOperacaoEnt.CxValorList[0].Valor := ValorNumEditBtu.AsCurrency
    end;
  end;
end;

procedure TCxOperUmValorEdForm.EntToControles;
begin
  inherited;
  if TrabPageControl.ActivePage = ValorTabSheet then
  begin
    ValorNumEditBtu.Valor := CxOperacaoEnt.Valor;
  end;
end;

function TCxOperUmValorEdForm.GetValorDoControle: Currency;
begin
  Result := 0;
  if TrabPageControl.ActivePage = ValorTabSheet then
  begin
    Result := ValorNumEditBtu.AsCurrency;
  end;
end;

procedure TCxOperUmValorEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  TrabPageControl.ActivePage := ValorTabSheet;
  ValorNumEditBtu.SetFocus;

  // FValorNumEdit.Valor := 18.76;
  // ObsMemo.Lines.text := 'Abertra teste';

  // OkAct_Diag.Execute;
  // TrabPageControl.ActivePage := NumerarioTabSheet;
end;

procedure TCxOperUmValorEdForm.TrabPageControlChange(Sender: TObject);
begin
  inherited;
  if TrabPageControl.ActivePage = ValorTabSheet then
    ValorNumEditBtu.SetFocus
  else if TrabPageControl.ActivePage = NumerarioTabSheet then
    FNumerarioListFrame.SelecionePrimeiro;
end;

procedure TCxOperUmValorEdForm.ValorNumEditBtuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
    SelectNext(TWinControl(Sender), True, True);
end;

end.
