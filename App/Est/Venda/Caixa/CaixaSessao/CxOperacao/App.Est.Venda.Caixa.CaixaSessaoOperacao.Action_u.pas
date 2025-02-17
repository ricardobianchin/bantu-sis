unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u;

interface

uses Vcl.ActnList, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, System.Classes,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Vcl.Controls,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI, App.UI.Form.Ed.CxOperacao_u,
  App.UI.Form.Ed.CxOperacao.UmValor_u, App.AppObj,
  App.Est.Venda.Caixa.CxValor.DBI, App.Est.Venda.Caixa.CaixaSessao;

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
    procedure Exec(Sender: TObject);
    function PodeExec: Boolean;
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
      pCxValorDBI: ICxValorDBI //
      ); reintroduce;
  end;

implementation

uses Vcl.Dialogs, Data.DB, forms, System.SysUtils;

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
  pCxValorDBI: ICxValorDBI //
  );
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FCaixaSessao := pCaixaSessao;
  FCxOperacaoTipo := pCxOperacaoTipo;
  FCxOperacaoTipoDBI := pCxOperacaoTipoDBI;
  FCxOperacaoEnt := pCxOperacaoEnt;
  FCxOperacaoDBI := pCxOperacaoDBI;
  FCxValorDBI := pCxValorDBI;

  Name := 'CxOperacao' + FCxOperacaoTipo.Name + 'Ins';
  Caption := FCxOperacaoTipo.Caption;
  Hint := FCxOperacaoTipo.Hint;
  OnExecute := Exec;
end;

function TCxOperacaoAction.CxOperacaoEdFormCreate: TCxOperacaoEdForm;
begin

  Result := TCxOperUmValorEdForm.Create(Nil, FAppObj, FCxOperacaoEnt,
    FCxOperacaoDBI, FCxValorDBI);

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
begin
  c := QuotedStr(FCxOperacaoTipo.Caption);

  if FCaixaSessao.Aberto then
  begin
    if FCxOperacaoTipo.HabilitadoDuranteSessao then
    begin
      Result := True;
    end
    else
    begin
      Result := False;
      sErro := 'Operação ' + c + ' não pode ser executada com Caixa aberto';
    end;
  end
  else
  begin
    if FCxOperacaoTipo.HabilitadoDuranteSessao then
    begin
      Result := False;
      sErro := 'Operação ' + c + ' não pode ser executada com Caixa fechado';
    end
    else
    begin
      Result := True;
    end;
  end;

  if Result then
    exit;

  raise Exception.Create(sErro);

(*
  Result := FCaixaSessao.Aberto = FCxOperacaoTipo.HabilitadoDuranteSessao;


  var
  a, h: Boolean;

  a := FCaixaSessao.Aberto;
  h := FCxOperacaoTipo.HabilitadoDuranteSessao;

  Result := (a and h) or ( (not a) and (not h));

  Result := not (a xor h);

  Result := (not FCaixaSessao.Aberto and
    not FCxOperacaoTipo.HabilitadoDuranteSessao) or
    (FCaixaSessao.Aberto and FCxOperacaoTipo.HabilitadoDuranteSessao);

  Result := not (FCaixaSessao.Aberto xor FCxOperacaoTipo.HabilitadoDuranteSessao);

|FCaixaSessao.Aberto|FCxOperacaoTipo.HabilitadoDuranteSessao|Result|
|-|-|-|
|False|False|True|
|False|True|False|
|True|False|False|
|True|True|True|

  *)
end;

end.
