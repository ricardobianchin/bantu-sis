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
  App.Est.Venda.Caixa.CxValor, Sis.Entities.Types, Sis.Win.Utils_u,
  Sis.Types.Dates, Sis.Types.Bool_u;

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
  PegueLinha('');

  s := 'SESSAO: ' + FCaixaSessao.GetCod;
  PegueLinha(s);

  FCaixaSessaoDBI.PreenchaCxSessRelatorio(FLinhasRet, FCaixaSessao);
end;

procedure TImpressaoTextoPDVCxSessRelat.GereTexto;
var
  i: integer;
  s: string;
  ss: string;
  Items: TArray<string>;
  uVal: Currency;
  uTot: Currency;
  iSinal: SmallInt;
begin
  inherited;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(FLinhasRet.Text);
  // {$ENDIF}
  FLinhasRet.SaveToFile('C:\Pr\app\bantu\bantu-sis\Exe\Tmp\linhasret.txt');

  i := 0;
  FCaixaSessao.LogUsuario.LojaId := StrToInt(FLinhasRet[i]);

  inc(i);
  FCaixaSessao.LogUsuario.Id := StrToInt(FLinhasRet[i]);

  inc(i);
  FCaixaSessao.LogUsuario.NomeExib := FLinhasRet[i];

  inc(i);
  FCaixaSessao.AbertoEm := TimeStampStrToDateTime(FLinhasRet[i]);

  s := 'OPERADOR: ' + FCaixaSessao.LogUsuario.Id.ToString + ' - ' +
    FCaixaSessao.LogUsuario.NomeExib;
  PegueLinha(s);

  s := 'ABERTO EM ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',
    FCaixaSessao.AbertoEm);
  PegueLinha(s);

  PegueLinha('');
  s := 'OPERACOES DE CAIXA';
  PegueLinha(CenterStr(s, NCols));
  uTot := 0;
  repeat
    inc(i);
    if i >= FLinhasRet.Count then
      break;

    Items := FLinhasRet[i].Split([';']);
    if Length(Items) = 0 then
      break;

    if Items[0] <> '2' then
      break;

    s := Items[1];

    iSinal := StrToInt(Items[2]);

    ss := Iif(iSinal > 0, '(+)', '(-)');
    OverwriteString(s, ss, 12);

    uVal := StrToCurrency(Items[3]);
    uTot := uTot + (iSinal * uVal);

    OverwriteStringRight(s, Items[3], 24);
    PegueLinha(s);
  until false;
  s := '';
  OverwriteStringRight(s, '-------------', 24);
  PegueLinha(s);

  s := '  TOTAL';
  OverwriteString(s, '(=)', 12);
  OverwriteStringRight(s, DinhToStr(uTot), 24);
  PegueLinha(s);

  PegueLinha('');

  {
    procedure OverwriteString(var aTargetStr: string; const aSourceStr: string;
    pStartPos: integer);
    procedure OverwriteStringRight(var aTargetStr: string; const aSourceStr: string;
    aEndPos: integer);

  }
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
