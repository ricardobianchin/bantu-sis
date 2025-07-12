unit App.PDV.ImpressaoTextoPOSPrinterCxOperacao_u;

interface

uses App.PDV.ImpressaoTexto.POSPrinter_u, App.AppObj, Sis.Terminal,
  App.PDV.Venda,
  App.PDV.VendaItem, App.PDV.CupomEspelho, App.PDV.VendaPag,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.DB.DBTypes;

type
  TImpressaoTextoPOSPrinterPDVCxOperacao = class(TImpressaoTextoPOSPrinterPDV)
  private
    FCxOperacaoEnt: ICxOperacaoEnt;
  protected
    procedure GereCabec; override;
    procedure GereRodape; override;

    procedure GereTexto; override;
    function GetDtDoc: TDateTime; override;
    function GetDocTitulo: string; override;
    function GetEspelhoAssuntoAtual: string; override;
  public
    constructor Create(pImpressoraNome: string; pUsuarioId: integer;
      pUsuarioNomeExib: string; pAppObj: IAppObj; pTerminal: ITerminal;
      pCxOperacaoEnt: ICxOperacaoEnt); reintroduce;
  end;

implementation

uses App.PDV.Factory_u, Sis.Types.strings_u, System.SysUtils, Sis.Types.Floats,
  App.Est.Venda.Caixa.CxValor;

{ TImpressaoTextoPOSPrinterPDVCxOperacao }

constructor TImpressaoTextoPOSPrinterPDVCxOperacao.Create(pImpressoraNome
  : string; pUsuarioId: integer; pUsuarioNomeExib: string; pAppObj: IAppObj;
  pTerminal: ITerminal; pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(pImpressoraNome, pUsuarioId, pUsuarioNomeExib, pAppObj,
    pTerminal, CupomEspelhoCxOperacaoCreate(pAppObj));
  FCxOperacaoEnt := pCxOperacaoEnt;
end;

procedure TImpressaoTextoPOSPrinterPDVCxOperacao.GereCabec;
var
  s: string;
  bColocaOrdem: Boolean;
begin
  inherited;
  // TIT
  s := FCxOperacaoEnt.CxOperacaoTipo.Abrev;

  bColocaOrdem := (FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopAbertura) and
    (FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopFechamento);

  if bColocaOrdem then
    s := s + ' ' + (FCxOperacaoEnt.OperTipoOrdem + 1).ToString;

  s := s + ' [' + FCxOperacaoEnt.GetCod(False) + ']';

  OverwriteStringRight(s, ' R$ ' + DinhToStr(FCxOperacaoEnt.Valor), 48);

  PegueLinha('</ae>' + s);

  if FCxOperacaoEnt.CxOperacaoTipo.Id = cxopSangria then
  begin
    PegueLinha('');
    PegueLinha('');
    PegueLinha('');
    s := StringOfChar('_', 26);
    PegueLinha('</ce>' + s);
    s := 'RESPONSAVEL';
    PegueLinha('</ce>' + s);
  end;
  // PegueLinha('');
end;

procedure TImpressaoTextoPOSPrinterPDVCxOperacao.GereRodape;
var
  s: string;
begin
  // if FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopAbertura then
  // s := FCxOperacaoEnt.GetCod
  // else
  // s := FCxOperacaoEnt.CaixaSessao.GetCod;

  s := FCxOperacaoEnt.GetCod;
  PegueLinha('</ce>' + s);
  inherited;
end;

procedure TImpressaoTextoPOSPrinterPDVCxOperacao.GereTexto;
var
  s: string;
  i: integer;
  v: ICxValor;
  bAdicionaAssinaturas: Boolean;
begin
  inherited;
  if FCxOperacaoEnt.Linhas.Count > 0 then
  begin
    for i := 0 to FCxOperacaoEnt.Linhas.Count - 1 do
    begin
      PegueLinha(FCxOperacaoEnt.Linhas[i]);
    end;
  end;
end;

function TImpressaoTextoPOSPrinterPDVCxOperacao.GetDocTitulo: string;
begin
  Result := FCxOperacaoEnt.CxOperacaoTipo.Name + ' ' + FCxOperacaoEnt.GetCod;
end;

function TImpressaoTextoPOSPrinterPDVCxOperacao.GetDtDoc: TDateTime;
begin
  Result := FCxOperacaoEnt.CriadoEm;
end;

function TImpressaoTextoPOSPrinterPDVCxOperacao.GetEspelhoAssuntoAtual: string;
begin
  Result := FCxOperacaoEnt.CxOperacaoTipo.Name + ' ' + FCxOperacaoEnt.GetCod;
end;

end.
