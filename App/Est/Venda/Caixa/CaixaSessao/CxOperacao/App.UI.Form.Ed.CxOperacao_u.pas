unit App.UI.Form.Ed.CxOperacao_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Sis.Usuario,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI, Sis.UI.Impressao, Sis.Terminal;

type
  TCxOperacaoEdForm = class(TEdBasForm)
    MeioPanel: TPanel;
    ObsPanel: TPanel;
    Label2: TLabel;
    ObsMemo: TMemo;
  private
    { Private declarations }
    FCxOperacaoEnt: ICxOperacaoEnt;
    FCxOperacaoDBI: ICxOperacaoDBI;
    FImpressao: IImpressao;
    FTerminal: ITerminal;
    FUsuario: IUsuario;
  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
    procedure AjusteTabOrder; virtual;
    property CxOperacaoEnt: ICxOperacaoEnt read FCxOperacaoEnt;
    property CxOperacaoDBI: ICxOperacaoDBI read FCxOperacaoDBI;
    function PodeOk: boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pUsuario: IUsuario;
      pEntEd: IEntEd; pEntDBI: IEntDBI); reintroduce;
  end;

var
  CxOperacaoEdForm: TCxOperacaoEdForm;

implementation

{$R *.dfm}

uses System.Math, App.Est.Venda.CaixaSessao.Factory_u, App.PDV.Factory_u;

{ TCxOperacaoEdForm }

procedure TCxOperacaoEdForm.AjusteControles;
begin
  inherited;

end;

procedure TCxOperacaoEdForm.AjusteTabOrder;
begin

end;

function TCxOperacaoEdForm.ControlesOk: boolean;
begin
  Result := True;
end;

procedure TCxOperacaoEdForm.ControlesToEnt;
begin
  FCxOperacaoEnt.Obs := ObsMemo.Lines.Text;
end;

constructor TCxOperacaoEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pUsuario: IUsuario; pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  FUsuario := pUsuario;
  FCxOperacaoEnt := EntEdCastToCxOperacaoEnt(pEntEd);
  FTerminal := pAppObj.TerminalList.TerminalIdToTerminal
    (FCxOperacaoEnt.CaixaSessao.TerminalId);
  FCxOperacaoDBI := EntDBICastToCxOperacaoDBI(pEntDBI);
  FImpressao := ImpressaoTextoCxOperacaoCreate(FTerminal.ImpressoraNome,
    FUsuario, pAppObj, FTerminal, FCxOperacaoEnt);

  Height := Min(600, Screen.WorkAreaRect.Height - 10);
  Width := 800;
end;

function TCxOperacaoEdForm.DadosOk: boolean;
begin
  Result := True;
end;

procedure TCxOperacaoEdForm.EntToControles;
begin
  ObsMemo.Lines.Text := FCxOperacaoEnt.Obs;
end;

function TCxOperacaoEdForm.GetObjetivoStr: string;
var
  { sFormat, } sTit, sNom, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := EntEd.NomeEnt;
  sVal := '';

  // sFormat := '%s %s: %s';
  // Result := Format(sFormat, [sTit, sNom, sVal]);
  Result := sNom;
end;

function TCxOperacaoEdForm.GravouOk: boolean;
begin
  Result := EntDBI.Gravar;
end;

function TCxOperacaoEdForm.PodeOk: boolean;
begin
  Result := inherited;
  if not Result then
    exit;
  FImpressao.Imprima;
end;

end.
