unit App.PDV.ImpressaoTextoCxOperacao_u;

interface

uses App.PDV.ImpressaoTexto_u, App.AppObj, Sis.Terminal, App.PDV.Venda,
  App.PDV.VendaItem, App.PDV.CupomEspelho, App.PDV.VendaPag,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u, Sis.DB.DBTypes;

type
  TImpressaoTextoPDVCxOperacao = class(TImpressaoTextoPDV)
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

{ TImpressaoTextoPDVCxOperacao }

constructor TImpressaoTextoPDVCxOperacao.Create(pImpressoraNome: string;
  pUsuarioId: integer; pUsuarioNomeExib: string; pAppObj: IAppObj;
  pTerminal: ITerminal; pCxOperacaoEnt: ICxOperacaoEnt);
begin
  inherited Create(pImpressoraNome, pUsuarioId, pUsuarioNomeExib, pAppObj, pTerminal,
    CupomEspelhoCxOperacaoCreate(pAppObj));
  FCxOperacaoEnt := pCxOperacaoEnt;
end;

procedure TImpressaoTextoPDVCxOperacao.GereCabec;
var
  s: string;
  bColocaOrdem: Boolean;
begin
  inherited;
  // TIT
  s := FCxOperacaoEnt.CxOperacaoTipo.Name;

  bColocaOrdem := (FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopAbertura) and
    (FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopFechamento);

  if bColocaOrdem then
    s := s + ' ' + FCxOperacaoEnt.OperTipoOrdem.ToString;
  PegueLinha(CenterStr(s, NCols));

  s := 'R$ ' + DinhToStr(FCxOperacaoEnt.Valor);
  PegueLinha(CenterStr(s, NCols));

  if FCxOperacaoEnt.CxOperacaoTipo.Id = cxopSangria then
  begin
    PegueLinha('');
    PegueLinha('');
    PegueLinha('');
    s := StringOfChar('_', 26);
    PegueLinha(CenterStr(s, NCols));
    s := 'OP: ' + UsuarioNomeExib;
    PegueLinha(CenterStr(s, NCols));

    PegueLinha('');
    PegueLinha('');
    PegueLinha('');
    s := StringOfChar('_', 26);
    PegueLinha(CenterStr(s, NCols));
    s := 'RESPONSAVEL';
    PegueLinha(CenterStr(s, NCols));
  end;
  // PegueLinha('');
end;

procedure TImpressaoTextoPDVCxOperacao.GereRodape;
var
  s: string;
begin
  // if FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopAbertura then
  // s := FCxOperacaoEnt.GetCod
  // else
  // s := FCxOperacaoEnt.CaixaSessao.GetCod;

  s := FCxOperacaoEnt.GetCod;
  PegueLinha(CenterStr(s, NCols));

  inherited;
end;

procedure TImpressaoTextoPDVCxOperacao.GereTexto;
var
  s: string;
  i: integer;
  v: ICxValor;
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

function TImpressaoTextoPDVCxOperacao.GetDocTitulo: string;
begin

  Result := FCxOperacaoEnt.CxOperacaoTipo.Name + ' ' + FCxOperacaoEnt.GetCod;
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
