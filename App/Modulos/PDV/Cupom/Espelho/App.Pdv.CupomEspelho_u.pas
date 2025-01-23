unit App.Pdv.CupomEspelho_u;

interface

uses
  App.Pdv.CupomEspelho, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Vcl.Dialogs;

type
  TCupomEspelho = class(TInterfacedObject, ICupomEspelho)
  private
    FAtivo: boolean;
    FPastaEspelho: string;
    FAssunto: string;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
  public
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);

    property Ativo: boolean read GetAtivo write SetAtivo;

    constructor Create(pPastaEspelho, pAssunto: string);
  end;

implementation

uses Sis.UI.IO.Files;

constructor TCupomEspelho.Create(pPastaEspelho, pAssunto: string);
begin
  FPastaEspelho := pPastaEspelho;
  FAssunto := pAssunto;
end;

procedure TCupomEspelho.Exibir(pFrase: string);
begin

end;

procedure TCupomEspelho.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  if not FAtivo then
    exit;
  Exibir(pFrase);
end;

function TCupomEspelho.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

procedure TCupomEspelho.SetAtivo(Value: boolean);
begin
  FAtivo := Value;
end;

end.
