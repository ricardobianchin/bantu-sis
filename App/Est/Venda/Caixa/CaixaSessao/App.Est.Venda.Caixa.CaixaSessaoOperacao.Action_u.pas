unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Action_u;

interface

uses Vcl.ActnList, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, System.Classes;

type
  TCxOperacaoAction = class(TAction)
  private
    FCxOperacaoTipo: ICxOperacaoTipo;
    FCxOperacaoTipoDBI: ICxOperacaoTipoDBI;
  protected
  public
    procedure AjusteEnabled;
    procedure ExecuteTarget(Target: TObject); override;
    function HandlesTarget(Target: TObject): Boolean; override;
    property CxOperacaoTipo: ICxOperacaoTipo read FCxOperacaoTipo;
    constructor Create(AOwner: TComponent; pCxOperacaoTipo: ICxOperacaoTipo;
      pCxOperacaoTipoDBI: ICxOperacaoTipoDBI); reintroduce;
  end;

implementation

{ TCxOperacaoAction }

procedure TCxOperacaoAction.AjusteEnabled;
begin
  Enabled := True;
end;

constructor TCxOperacaoAction.Create(AOwner: TComponent;
  pCxOperacaoTipo: ICxOperacaoTipo; pCxOperacaoTipoDBI: ICxOperacaoTipoDBI);
begin
  inherited Create(AOwner);
  FCxOperacaoTipo := pCxOperacaoTipo;
  FCxOperacaoTipoDBI := pCxOperacaoTipoDBI;

  Name := 'CxOperacao' + FCxOperacaoTipo.Name + 'Ins';
  Caption := FCxOperacaoTipo.Caption;
  Hint := FCxOperacaoTipo.Hint;
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
