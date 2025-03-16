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
    procedure ObsMemoKeyPress(Sender: TObject; var Key: Char);
    procedure OkAct_DiagExecute(Sender: TObject);
  private
    { Private declarations }
    FCxOperacaoEnt: ICxOperacaoEnt;
    FCxOperacaoDBI: ICxOperacaoDBI;
    FImpressao: IImpressao;
    FTerminal: ITerminal;
    FUsuarioId: integer;
    FUsuarioNomeExib: string;
  protected
    function GetSqlGarantir: string; virtual;

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
    property UsuarioId: integer read FUsuarioId;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pUsuarioId: integer; pUsuarioNomeExib: string; pEntEd: IEntEd;
      pEntDBI: IEntDBI); reintroduce;
  end;

var
  CxOperacaoEdForm: TCxOperacaoEdForm;

implementation

{$R *.dfm}

uses System.Math, App.Est.Venda.CaixaSessao.Factory_u, App.PDV.Factory_u,
  Sis.Types.Floats, Sis.Entities.Types, App.Est.Venda.Caixa.CaixaSessao.Utils_u;

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
  pUsuarioId: integer; pUsuarioNomeExib: string; pEntEd: IEntEd;
  pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  FUsuarioId := pUsuarioId;
  FUsuarioNomeExib := pUsuarioNomeExib;

  FCxOperacaoEnt := EntEdCastToCxOperacaoEnt(pEntEd);
  FCxOperacaoDBI := EntDBICastToCxOperacaoDBI(pEntDBI);

  FTerminal := pAppObj.TerminalList.TerminalIdToTerminal
    (FCxOperacaoEnt.CaixaSessao.TerminalId);
  FImpressao := ImpressaoTextoCxOperacaoCreate(FTerminal.ImpressoraNome,
    pUsuarioId, pUsuarioNomeExib, pAppObj, FTerminal, FCxOperacaoEnt);

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

function TCxOperacaoEdForm.GetSqlGarantir: string;
var
  Ent: ICxOperacaoEnt;
begin
  Ent := FCxOperacaoEnt;// so pra tornar mais legivel

  Result := 'SELECT'#13#10

    + 'SESS_ID_RET'#13#10 // 0
    + ', OPER_ORDEM_RET'#13#10 // 1
    + ', OPER_LOG_ID_RET'#13#10 // 2
    + ', OPER_TIPO_ORDEM_RET'#13#10 // 3
    + ', LOG_DTH'#13#10 // 4

    + 'FROM CAIXA_SESSAO_MANUT_PA.CAIXA_SESSAO_OPERACAO_INSERIR_DO'#13#10 //

    + '('#13#10 //

    + '  ' + Ent.CaixaSessao.LojaId.ToString + ' -- loja_id'#13#10 //
    + '  , ' + Ent.CaixaSessao.TerminalId.ToString + ' -- terminal_id'#13#10 //
    + '  , ' + Ent.CaixaSessao.Id.ToString + ' -- sess id'#13#10 //
    + '  , null' + ' -- oper ordem'#13#10 // + Ent.OperOrdem.ToString //
    + '  , ' + Ent.CxOperacaoTipo.Id.ToSqlConstant + ' -- oper tipo'#13#10 //
    + '  , ' + Ent.LogId.ToString + ' -- log id'#13#10 //
    + '  , null' + ' -- tipo ordem'#13#10 // + Ent.OperTipoOrdem.ToString //
    + '  , ' + CurrencyToStrPonto(Ent.Valor) + ' -- valor'#13#10 //
    + '  , ' + QuotedStr(Ent.Obs) + ' -- obs'#13#10 //

    + '  , ' + FUsuarioId.ToString + ' -- usu id'#13#10 //
    + '  , ' + Ent.CaixaSessao.MachineIdentId.ToString + ' -- machine id'#13#10
  //
    + '  , ' + QuotedStr(Ent.CxValorList.AsList) + ' -- valor list'#13#10 //
    + '  , ' + QuotedStr(Ent.CxValorList.NumerarioAsList) +
    ' -- numerario list'#13#10 //

    + ');' //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

function TCxOperacaoEdForm.GravouOk: boolean;
var
  sMens: string;
begin
  Result := FCxOperacaoDBI.ExecuteSQL(GetSqlGarantir, sMens);
  if not Result then
    ErroOutput.Exibir(sMens);
end;

procedure TCxOperacaoEdForm.ObsMemoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    OkAct_Diag.Execute;
  end;
end;

procedure TCxOperacaoEdForm.OkAct_DiagExecute(Sender: TObject);
begin
  inherited;
  FImpressao.Imprima;

end;

function TCxOperacaoEdForm.PodeOk: boolean;
begin
  Result := inherited;
  if not Result then
    exit;
end;

end.
