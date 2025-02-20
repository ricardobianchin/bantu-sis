unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u;

interface

uses Vcl.ActnList, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, System.Classes,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Vcl.Controls, Sis.Usuario,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI, App.UI.Form.Ed.CxOperacao_u,
  App.UI.Form.Ed.CxOperacao.UmValor_u, App.UI.Form.Ed.CxOperacao.Valores_u,
  App.AppObj, App.Est.Venda.Caixa.CxValor.DBI, App.Est.Venda.Caixa.CaixaSessao,
  App.PDV.Controlador;

type
  TCxOperacaoAction = class(TAction)
  private
    FCaixaSessao: ICaixaSessao;
    FCxOperacaoTipo: ICxOperacaoTipo;
    FCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
    FCxOperacaoEnt: ICxOperacaoEnt;
    FCxOperacaoDBI: ICxOperacaoDBI;
    FAppObj: IAppObj;
    FCxValorDBI: ICxValorDBI;
    FPDVControlador: IPDVControlador;
    FUsuario: IUsuario;

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
      pUsuario: IUsuario; //
      pCxValorDBI: ICxValorDBI; //
      pPDVControlador: IPDVControlador); reintroduce;
  end;

implementation

uses Vcl.Dialogs, Data.DB, forms, System.SysUtils, Sis.Types.Bool_u,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u;

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
  pUsuario: IUsuario; //
  pCxValorDBI: ICxValorDBI; //
  pPDVControlador: IPDVControlador);
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FUsuario := pUsuario;
  FCaixaSessao := pCaixaSessao;
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
      Result := TCxOperUmValorEdForm.Create(Nil, FAppObj, FUsuario,
        FCxOperacaoEnt, FCxOperacaoDBI, FCxValorDBI);

    cxopFechamento: //
      Result := TCxOperValoresEdForm.Create(Nil, FAppObj, FUsuario,
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
  FPDVControlador.DecidirPrimeroFrameAtivo;
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
begin
  if FCxOperacaoTipo.Id = cxopFechamento then
  begin
    FCxOperacaoDBI.FecharPodeGet(Result, sMensagem);
    if not Result then
    begin
      raise Exception.Create(sMensagem);
    end;
  end;

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
