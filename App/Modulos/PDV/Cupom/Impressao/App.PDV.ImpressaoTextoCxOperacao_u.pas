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
  sn: string;
begin
  inherited;
  sn := FCxOperacaoEnt.CxOperacaoTipo.Name;
  PegueLinha(CenterStr(sn, NCols));
  PegueLinha(CenterStr('', NCols));

  s := 'SESSAO DE CAIXA: ' + FCxOperacaoEnt.CaixaSessao.GetCod;
  PegueLinha(CenterStr(s, NCols));
  PegueLinha(CenterStr('', NCols));

  if FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopAbertura then
  begin
    s := 'NUM.ORDEM: ' + FCxOperacaoEnt.OperOrdem.ToString;
    PegueLinha(CenterStr(s, NCols));

    s := 'NUM.ORDEM '+sn+': ' + FCxOperacaoEnt.OperTipoOrdem.ToString;
    PegueLinha(CenterStr(s, NCols));
  end;
  PegueLinha(CenterStr('', NCols));

  s := 'VALOR R$ ' + DinhToStr(FCxOperacaoEnt.Valor);
  PegueLinha(CenterStr(s, NCols));

  case FCxOperacaoEnt.CxOperacaoTipo.Id of
    cxopNaoIndicado:
      ;
    cxopAbertura:
      begin
      end;
    cxopSangria:
      ;
    cxopSuprimento:
      ;
    cxopVale:
      ;
    cxopDespesa:
      ;
    cxopConvenio:
      ;
    cxopCrediario:
      ;
    cxopFechamento:
      ;
    cxopDevolucao:
      ;
    cxopVenda:
      ;
  end;

  s := 'OPERACAO: ' + FCxOperacaoEnt.GetCod;
  PegueLinha(s);

  s := 'NUM.ORDEM OPERACAO: ' + FCxOperacaoEnt.OperOrdem.ToString;
  PegueLinha(s);

  s := 'NUM.ORDEM ' + FCxOperacaoEnt.CxOperacaoTipo.Name + ': ' +
    FCxOperacaoEnt.OperOrdem.ToString;
  PegueLinha(s);

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

end.
