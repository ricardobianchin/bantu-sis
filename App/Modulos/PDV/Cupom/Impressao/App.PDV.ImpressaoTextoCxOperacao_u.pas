unit App.PDV.ImpressaoTextoCxOperacao_u;

interface

uses App.PDV.ImpressaoTexto_u, App.AppObj, Sis.Terminal, App.PDV.Venda,
  App.PDV.VendaItem, App.PDV.CupomEspelho, App.PDV.VendaPag,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Sis.Usuario;

type
  TImpressaoTextoPDVCxOperacao = class(TImpressaoTextoPDV)
  private
    FCxOperacaoEnt: ICxOperacaoEnt;
  protected
    procedure GereTexto; override;
    function GetDtDoc: TDateTime; override;
  public
    constructor Create(pImpressoraNome: string; pUsuario: IUsuario;
      pAppObj: IAppObj; pTerminal: ITerminal; pCxOperacaoEnt: ICxOperacaoEnt);
  end;

implementation

uses App.PDV.Factory_u;

{ TImpressaoTextoPDVCxOperacao }

constructor TImpressaoTextoPDVCxOperacao.Create(pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(pImpressoraNome, pUsuario, pAppObj, pTerminal,
    CupomEspelhoCxOperacaoCreate(pAppObj));

end;

procedure TImpressaoTextoPDVCxOperacao.GereTexto;
begin
  inherited;

end;

function TImpressaoTextoPDVCxOperacao.GetDtDoc: TDateTime;
begin

end;

end.
