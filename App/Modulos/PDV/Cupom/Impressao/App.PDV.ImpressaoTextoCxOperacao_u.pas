unit App.PDV.ImpressaoTextoCxOperacao_u;

interface

uses App.PDV.ImpressaoTexto_u, App.AppObj, Sis.Terminal, App.PDV.Venda,
  App.PDV.VendaItem, App.PDV.CupomEspelho, App.PDV.VendaPag,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Sis.Usuario,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u;

type
  TImpressaoTextoPDVCxOperacao = class(TImpressaoTextoPDV)
  private
    FCxOperacaoEnt: ICxOperacaoEnt;
  protected
    procedure GereCabec; override;
    procedure GereTexto; override;
    function GetDtDoc: TDateTime; override;
    function GetDocTitulo: string; override;
    function GetEspelhoAssuntoAtual: string; override;
  public
    constructor Create(pImpressoraNome: string; pUsuario: IUsuario;
      pAppObj: IAppObj; pTerminal: ITerminal; pCxOperacaoEnt: ICxOperacaoEnt);
  end;

implementation

uses App.PDV.Factory_u, Sis.Types.strings_u, System.SysUtils, Sis.Types.Floats;

{ TImpressaoTextoPDVCxOperacao }

constructor TImpressaoTextoPDVCxOperacao.Create(pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(pImpressoraNome, pUsuario, pAppObj, pTerminal,
    CupomEspelhoCxOperacaoCreate(pAppObj));
  FCxOperacaoEnt := pCxOperacaoEnt;
end;

procedure TImpressaoTextoPDVCxOperacao.GereCabec;
var
  s: string;
begin
  inherited;
  PegueLinha('');

  // TIT
  s := FCxOperacaoEnt.CxOperacaoTipo.Name;

  if FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopAbertura then
    s := s + ' ' + (FCxOperacaoEnt.OperTipoOrdem + 1).ToString;
  PegueLinha(CenterStr(s, NCols));

  if FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopFechamento then
  begin
    s := 'R$ ' + DinhToStr(FCxOperacaoEnt.Valor);
    PegueLinha(CenterStr(s, NCols));
    PegueLinha('');
  end;

  if FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopAbertura then
    s := FCxOperacaoEnt.GetCod
  else
    s := FCxOperacaoEnt.CaixaSessao.GetCod;

  PegueLinha(CenterStr(s, NCols));
end;

procedure TImpressaoTextoPDVCxOperacao.GereTexto;
begin
  inherited;

end;

function TImpressaoTextoPDVCxOperacao.GetDocTitulo: string;
begin

end;

function TImpressaoTextoPDVCxOperacao.GetDtDoc: TDateTime;
begin
  Result := FCxOperacaoEnt.CriadoEm;
end;

function TImpressaoTextoPDVCxOperacao.GetEspelhoAssuntoAtual: string;
begin
  Result := FCxOperacaoEnt.CxOperacaoTipo.Name + ' ' + FCxOperacaoEnt.GetCod;
end;

end.
