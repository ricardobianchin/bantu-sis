unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u;

interface

uses Vcl.ActnList, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, System.Classes, App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent;

type
  TCxOperacaoAction = class(TAction)
  private
    FCxOperacaoTipo: ICxOperacaoTipo;
    FCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
    FCxOperacaoEnt: ICxOperacaoEnt;
  protected
  public
    procedure AjusteEnabled;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    property CxOperacaoTipo: ICxOperacaoTipo read FCxOperacaoTipo;
    property CxOperacaoEnt: ICxOperacaoEnt read FCxOperacaoEnt;
    constructor Create(AOwner: TComponent; pCxOperacaoTipo: ICxOperacaoTipo;
      pCxOperacaoTipoDBI: ICxOperacaoTipoDBI; pCxOperacaoEnt: ICxOperacaoEnt); reintroduce;
  end;

implementation

uses Vcl.Dialogs;

{ TCxOperacaoAction }

procedure TCxOperacaoAction.AjusteEnabled;
begin
  Enabled := True;
end;

constructor TCxOperacaoAction.Create(AOwner: TComponent;
  pCxOperacaoTipo: ICxOperacaoTipo; pCxOperacaoTipoDBI: ICxOperacaoTipoDBI; pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(AOwner);
  FCxOperacaoTipo := pCxOperacaoTipo;
  FCxOperacaoTipoDBI := pCxOperacaoTipoDBI;
  FCxOperacaoEnt := pCxOperacaoEnt;
  Name := 'CxOperacao' + FCxOperacaoTipo.Name + 'Ins';
  Caption := FCxOperacaoTipo.Caption;
  Hint := FCxOperacaoTipo.Hint;
end;

procedure TCxOperacaoAction.ExecuteTarget(Target: TObject);
begin
  inherited;
  Showmessage('a');
end;

function TCxOperacaoAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := inherited;
end;

end.
