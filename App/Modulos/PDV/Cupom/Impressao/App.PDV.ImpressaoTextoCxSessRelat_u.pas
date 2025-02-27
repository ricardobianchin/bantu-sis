unit App.PDV.ImpressaoTextoCxSessRelat_u;

interface

uses App.PDV.ImpressaoTexto_u, App.AppObj, Sis.Terminal, Sis.Usuario,
  App.Est.Venda.CaixaSessao.DBI, App.Est.Venda.CaixaSessaoRecord_u,
  System.Classes;

type
  TImpressaoTextoPDVCxSessRelat = class(TImpressaoTextoPDV)
  private
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FCaixaSessaoRec: TCaixaSessaoRec;
    FLinhasRet: TStringList;
  protected
    procedure GereCabec; override;

    procedure GereTexto; override;
    function GetDtDoc: TDateTime; override;
    function GetDocTitulo: string; override;
    function GetEspelhoAssuntoAtual: string; override;
  public
    constructor Create(pImpressoraNome: string; pUsuario: IUsuario;
      pAppObj: IAppObj; pTerminal: ITerminal; pCaixaSessaoDBI: ICaixaSessaoDBI;
      pCaixaSessaoRec: TCaixaSessaoRec);
    destructor Destroy; override;

  end;

implementation

uses App.PDV.Factory_u, Sis.Types.strings_u, System.SysUtils, Sis.Types.Floats,
  App.Est.Venda.Caixa.CxValor, Sis.Entities.Types;

{ TImpressaoTextoPDVCxSessRelat }

constructor TImpressaoTextoPDVCxSessRelat.Create(pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCaixaSessaoDBI: ICaixaSessaoDBI; pCaixaSessaoRec: TCaixaSessaoRec);
begin
  inherited Create(pImpressoraNome, pUsuario, pAppObj, pTerminal,
    CupomEspelhoCxOperacaoCreate(pAppObj));
  FLinhasRet := TStringList.Create;
  FCaixaSessaoDBI := pCaixaSessaoDBI;
  FCaixaSessaoRec := pCaixaSessaoRec;
end;

destructor TImpressaoTextoPDVCxSessRelat.Destroy;
begin
  FLinhasRet.Free;
  inherited;
end;

procedure TImpressaoTextoPDVCxSessRelat.GereCabec;
var
  s: string;
begin
  inherited;
  // if FCxOperacaoEnt.CxOperacaoTipo.Id <> cxopAbertura then
  // s := FCxOperacaoEnt.GetCod
  // else
  // s := FCxOperacaoEnt.CaixaSessao.GetCod;

  s := 'RELATORIO DE CAIXA';
  PegueLinha(CenterStr(s, NCols));

  s := Sis.Entities.Types.GetCod(FCaixaSessaoRec.LojaId,
    FCaixaSessaoRec.TerminalId, FCaixaSessaoRec.SessId, 'CX');

  s := 'SESSAO: ' + s;
  PegueLinha(CenterStr(s, NCols));

  FCaixaSessaoDBI.PreenchaCxSessRelatorio(FLinhasRet, FCaixaSessaoRec);

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
