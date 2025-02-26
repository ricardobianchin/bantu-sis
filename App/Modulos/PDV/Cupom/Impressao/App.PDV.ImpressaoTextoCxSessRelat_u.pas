unit App.PDV.ImpressaoTextoCxSessRelat_u;

interface

uses App.PDV.ImpressaoTexto_u, App.AppObj, Sis.Terminal, Sis.Usuario,
  App.Est.Venda.CaixaSessao.DBI;

type
  TImpressaoTextoPDVCxSessRelat = class(TImpressaoTextoPDV)
  private
    FCaixaSessaoDBI: ICaixaSessaoDBI;
  protected
    procedure GereCabec; override;
    procedure GereRodape; override;

    procedure GereTexto; override;
    function GetDtDoc: TDateTime; override;
    function GetDocTitulo: string; override;
    function GetEspelhoAssuntoAtual: string; override;
  public
    constructor Create(pImpressoraNome: string; pUsuario: IUsuario;
      pAppObj: IAppObj; pTerminal: ITerminal; pCaixaSessaoDBI: ICaixaSessaoDBI);
  end;

implementation

uses App.PDV.Factory_u, Sis.Types.strings_u, System.SysUtils, Sis.Types.Floats,
  App.Est.Venda.Caixa.CxValor;

{ TImpressaoTextoPDVCxSessRelat }

constructor TImpressaoTextoPDVCxSessRelat.Create(pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCaixaSessaoDBI: ICaixaSessaoDBI);
begin
  inherited Create(pImpressoraNome, pUsuario, pAppObj, pTerminal,
    CupomEspelhoCxOperacaoCreate(pAppObj));
  FCaixaSessaoDBI := pCaixaSessaoDBI;
end;

procedure TImpressaoTextoPDVCxSessRelat.GereCabec;
begin
  inherited;

end;

procedure TImpressaoTextoPDVCxSessRelat.GereRodape;
begin
  inherited;

end;

procedure TImpressaoTextoPDVCxSessRelat.GereTexto;
begin
  inherited;

end;

function TImpressaoTextoPDVCxSessRelat.GetDocTitulo: string;
begin

end;

function TImpressaoTextoPDVCxSessRelat.GetDtDoc: TDateTime;
begin

end;

function TImpressaoTextoPDVCxSessRelat.GetEspelhoAssuntoAtual: string;
begin

end;

end.
