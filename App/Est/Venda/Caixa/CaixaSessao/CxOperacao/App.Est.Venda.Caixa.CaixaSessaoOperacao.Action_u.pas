unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u;

interface

uses Vcl.ActnList, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, System.Classes,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Vcl.Controls,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI, App.UI.Form.Ed.CxOperacao_u,
  App.UI.Form.Ed.CxOperacao.UmValor_u, App.UI.Form.Ed.CxOperacao.Valores_u,
  App.AppObj, App.Est.Venda.Caixa.CxValor.DBI, App.Est.Venda.Caixa.CaixaSessao,
  App.PDV.Controlador, App.Est.Venda.CaixaSessao.DBI;

type
  TCxOperacaoAction = class(TAction)
  private
    FCaixaSessao: ICaixaSessao;
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FCxOperacaoTipo: ICxOperacaoTipo;
    FCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
    FCxOperacaoEnt: ICxOperacaoEnt;
    FCxOperacaoDBI: ICxOperacaoDBI;
    FAppObj: IAppObj;
    FCxValorDBI: ICxValorDBI;
    FPDVControlador: IPDVControlador;
    FUsuarioId: integer;
    FUsuarioNomeExib: string;
    function PodeExec: Boolean;
    procedure Exec(Sender: TObject);
  protected
    function CxOperacaoEdFormCreate: TCxOperacaoEdForm; virtual;
  public
    procedure AjusteEnabled;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    property CxOperacaoTipo: ICxOperacaoTipo read FCxOperacaoTipo;
    property CxOperacaoEnt: ICxOperacaoEnt read FCxOperacaoEnt;
    constructor Create( //
      AOwner: TComponent; //
      pCaixaSessao: ICaixaSessao; //
      pCxOperacaoTipo: ICxOperacaoTipo; //
      pCxOperacaoTipoDBI: ICxOperacaoTipoDBI; //
      pCxOperacaoEnt: ICxOperacaoEnt; //
      pCxOperacaoDBI: ICxOperacaoDBI; //
      pAppObj: IAppObj; //
      pUsuarioId: integer; //
      pUsuarioNomeExib: string; //
      pCxValorDBI: ICxValorDBI; //
      pPDVControlador: IPDVControlador;//
      pCaixaSessaoDBI: ICaixaSessaoDBI
      ); reintroduce;
  end;

implementation

uses Vcl.Dialogs, Data.DB, forms, System.SysUtils, Sis.Types.Bool_u,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.Usuario.Factory, Sis.Usuario.DBI;

{ TCxOperacaoAction }

procedure TCxOperacaoAction.AjusteEnabled;
begin
  Enabled := True;
end;

constructor TCxOperacaoAction.Create( //
  AOwner: TComponent; //
  pCaixaSessao: ICaixaSessao; //
  pCxOperacaoTipo: ICxOperacaoTipo; //
  pCxOperacaoTipoDBI: ICxOperacaoTipoDBI; //
  pCxOperacaoEnt: ICxOperacaoEnt; //
  pCxOperacaoDBI: ICxOperacaoDBI; //
  pAppObj: IAppObj; //
  pUsuarioId: integer; //
  pUsuarioNomeExib: string; //
  pCxValorDBI: ICxValorDBI; //
      pPDVControlador: IPDVControlador;//
      pCaixaSessaoDBI: ICaixaSessaoDBI
  );
//var
//  oUsuarioDBI: IUsuarioDBI;
begin
  inherited Create(AOwner);
  FUsuarioId := pUsuarioId;
  FUsuarioNomeExib := pUsuarioNomeExib;

  FCaixaSessao := pCaixaSessao;
  FCaixaSessaoDBI := pCaixaSessaoDBI;
  FCxOperacaoTipo := pCxOperacaoTipo;
  FCxOperacaoTipoDBI := pCxOperacaoTipoDBI;
  FCxOperacaoEnt := pCxOperacaoEnt;
  FCxOperacaoDBI := pCxOperacaoDBI;
  FCxValorDBI := pCxValorDBI;
  FPDVControlador := pPDVControlador;

  Name := 'CxOperacao' + FCxOperacaoTipo.Name + 'Ins';
  Caption := FCxOperacaoTipo.Caption;
  Hint := FCxOperacaoTipo.Hint;
  OnExecute := Exec;
end;

function TCxOperacaoAction.CxOperacaoEdFormCreate: TCxOperacaoEdForm;
begin
  Result := nil;

  case FCxOperacaoEnt.CxOperacaoTipo.Id of
    cxopNaoIndicado:
      ;
    cxopAbertura //
      , cxopSangria //
      , cxopSuprimento: //
      Result := TCxOperUmValorEdForm.Create(Nil, FAppObj, FUsuarioId, FUsuarioNomeExib,
        FCxOperacaoEnt, FCxOperacaoDBI, FCxValorDBI);

    cxopFechamento: //
      Result := TCxOperValoresEdForm.Create(Nil, FAppObj, FUsuarioId, FUsuarioNomeExib,
        FCxOperacaoEnt, FCxOperacaoDBI, FCxValorDBI);

    cxopVale: //
      ;
    cxopDespesa: //
      ;
    cxopConvenio: //
      ;
    cxopCrediario: //
      ;
    cxopDevolucao: //
      ;
    cxopVenda: //
      ;
  end;

  // Result.Parent := Application.MainForm;
  // Result.Align :=alclient;
end;

procedure TCxOperacaoAction.Exec(Sender: TObject);
var
  f: TCxOperacaoEdForm;
begin
  if not PodeExec then
    exit;

  FCxOperacaoEnt.State := TDataSetState.dsInsert;
  f := CxOperacaoEdFormCreate;
  f.Perg;
  f.Free;
  FPDVControlador.DecidirPrimeiroFrameAtivo;
end;

procedure TCxOperacaoAction.ExecuteTarget(Target: TObject);
begin
  inherited;
end;

function TCxOperacaoAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := inherited;
end;

function TCxOperacaoAction.PodeExec: Boolean;
var
  sErro: string;
  c: string;
  A, H: Boolean;
  status: string;
  sMensagem: string;
  i: integer;
begin
  if FCxOperacaoTipo.Id = cxopFechamento then
  begin
    FCxOperacaoDBI.FecharPodeGet(Result, sMensagem);
    if not Result then
    begin
      raise Exception.Create(sMensagem);
    end;
  end;
  FCaixaSessaoDBI.PegDados(FCaixaSessao);
  i := FCaixaSessao.Id;
  c := QuotedStr(FCxOperacaoTipo.Caption);
  A := FCaixaSessao.Aberto;
  H := FCxOperacaoTipo.HabilitadoDuranteSessao;

  // Aplicando a tabela verdade diretamente
  Result := not(A xor H);

  if Result then
    exit;

  status := Iif(A, 'aberto', 'fechado');
  sErro := 'Operação ' + c + ' não pode ser executada com Caixa ' + status;
  raise Exception.Create(sErro);

end;

end.
