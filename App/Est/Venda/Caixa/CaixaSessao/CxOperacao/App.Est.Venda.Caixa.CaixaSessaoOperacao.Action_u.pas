unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u;

interface

uses Vcl.ActnList, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, System.Classes,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Vcl.Controls,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI, App.UI.Form.Ed.CxOperacao_u,
  App.UI.Form.Ed.CxOperacao.UmValor_u, App.AppObj, App.Est.Venda.Caixa.CxValor.DBI;

type
  TCxOperacaoAction = class(TAction)
  private
    FCxOperacaoTipo: ICxOperacaoTipo;
    FCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
    FCxOperacaoEnt: ICxOperacaoEnt;
    FCxOperacaoDBI: ICxOperacaoDBI;
    FAppObj: IAppObj;
    FCxValorDBI: ICxValorDBI;
    procedure Exec(Sender: TObject);
  protected
    function CxOperacaoEdFormCreate: TCxOperacaoEdForm; virtual;
  public
    procedure AjusteEnabled;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    property CxOperacaoTipo: ICxOperacaoTipo read FCxOperacaoTipo;
    property CxOperacaoEnt: ICxOperacaoEnt read FCxOperacaoEnt;
    constructor Create(AOwner: TComponent; pCxOperacaoTipo: ICxOperacaoTipo;
      pCxOperacaoTipoDBI: ICxOperacaoTipoDBI; pCxOperacaoEnt: ICxOperacaoEnt;
      pAppObj: IAppObj; pCxValorDBI: ICxValorDBI); reintroduce;
  end;

implementation

uses Vcl.Dialogs, Data.DB, forms;

{ TCxOperacaoAction }

procedure TCxOperacaoAction.AjusteEnabled;
begin
  Enabled := True;
end;

constructor TCxOperacaoAction.Create(AOwner: TComponent;
  pCxOperacaoTipo: ICxOperacaoTipo; pCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
  pCxOperacaoEnt: ICxOperacaoEnt; pAppObj: IAppObj; pCxValorDBI: ICxValorDBI);
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FCxOperacaoTipo := pCxOperacaoTipo;
  FCxOperacaoTipoDBI := pCxOperacaoTipoDBI;
  FCxOperacaoEnt := pCxOperacaoEnt;
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

//  Result.Parent := Application.MainForm;
//  Result.Align :=alclient;
end;

procedure TCxOperacaoAction.Exec(Sender: TObject);
var
  f: TCxOperacaoEdForm;
begin
  FCxOperacaoEnt.State := TDataSetState.dsInsert;
  F := CxOperacaoEdFormCreate;
  F.Perg;
  F.Free;
end;

procedure TCxOperacaoAction.ExecuteTarget(Target: TObject);
begin
  inherited;
end;

function TCxOperacaoAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := inherited;
end;

end.
