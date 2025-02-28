unit App.PDV.ImpressaoTextoCxSessRelat_u;

interface

uses App.PDV.ImpressaoTexto_u, App.AppObj, Sis.Terminal, Sis.Usuario,
  App.Est.Venda.CaixaSessao.DBI, System.Classes,
  App.Est.Venda.Caixa.CaixaSessao;

type
  TImpressaoTextoPDVCxSessRelat = class(TImpressaoTextoPDV)
  private
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FCaixaSessao: ICaixaSessao;
    FLinhasRet: TStringList;
  protected
    procedure GereCabec; override;

    procedure GereTexto; override;
    function GetDocTitulo: string; override;
    function GetEspelhoAssuntoAtual: string; override;
  public
    constructor Create(pImpressoraNome: string; pUsuario: IUsuario;
      pAppObj: IAppObj; pTerminal: ITerminal; pCaixaSessaoDBI: ICaixaSessaoDBI;
      pCaixaSessao: ICaixaSessao);
    destructor Destroy; override;
  end;

implementation

uses App.PDV.Factory_u, Sis.Types.strings_u, System.SysUtils, Sis.Types.Floats,
  App.Est.Venda.Caixa.CxValor, Sis.Entities.Types, Sis.Win.Utils_u;

{ TImpressaoTextoPDVCxSessRelat }

constructor TImpressaoTextoPDVCxSessRelat.Create(pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCaixaSessaoDBI: ICaixaSessaoDBI; pCaixaSessao: ICaixaSessao);
begin
  inherited Create(pImpressoraNome, pUsuario, pAppObj, pTerminal,
    CupomEspelhoCxOperacaoCreate(pAppObj));
  FLinhasRet := TStringList.Create;
  FCaixaSessaoDBI := pCaixaSessaoDBI;
  FCaixaSessao := pCaixaSessao;
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
  s := 'RELATORIO DE CAIXA';
  PegueLinha(CenterStr(s, NCols));

  s := 'SESSAO: ' + FCaixaSessao.GetCod;
  PegueLinha(CenterStr(s, NCols));

  FCaixaSessaoDBI.PreenchaCxSessRelatorio(FLinhasRet, FCaixaSessao);

{$IFDEF DEBUG}
  CopyTextToClipboard(FLinhasRet.Text);
{$ENDIF}
end;

procedure TImpressaoTextoPDVCxSessRelat.GereTexto;
begin
  inherited;

end;

function TImpressaoTextoPDVCxSessRelat.GetDocTitulo: string;
begin
  Result := 'Relatorio de Caixa ' + FCaixaSessao.GetCod;
end;

function TImpressaoTextoPDVCxSessRelat.GetEspelhoAssuntoAtual: string;
begin
  Result := FCaixaSessao.GetCod;
end;

end.
