unit App.PDV.ImpressaoTexto_u;

interface

uses Sis.UI.ImpressaoTexto_u, App.AppObj, Sis.Terminal, App.PDV.CupomEspelho,
  Sis.Usuario, Sis.Sis.Constants;

type
  TImpressaoTextoPDV = class(TImpressaoTexto)
  private
    FImpressoraNome: string;
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FCupomEspelho: ICupomEspelho;
    function GetNCols: integer;
  protected
    property ImpressoraNome: string read FImpressoraNome;
    property AppObj: IAppObj read FAppObj;
    property Terminal: ITerminal read FTerminal;
    property NCols: integer read GetNCols;
    function GetAtivo: Boolean; override;

    // procedure GereInicio; override;
    procedure GereCabec; override;
    procedure GereFim; override;
    // procedure EnvieImpressao; override;
    procedure GereTexto; override;
    procedure PegueSeparador(pCharSeparador: Char = '-');
    function GetEspelhoAssuntoAtual: string; virtual;

  public
    constructor Create(pImpressoraNome: string; pUsuario: IUsuario;
      pAppObj: IAppObj; pTerminal: ITerminal; pCupomEspelho: ICupomEspelho);
  end;

implementation

uses Sis.Types.strings_u, {System.DateUtils,} System.SysUtils, Sis.Types.Dates;

{ TImpressaoTextoPDV }

constructor TImpressaoTextoPDV.Create(pImpressoraNome: string;
  pUsuario: IUsuario; pAppObj: IAppObj; pTerminal: ITerminal;
  pCupomEspelho: ICupomEspelho);
begin
  inherited Create(pImpressoraNome, pUsuario);
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FCupomEspelho := pCupomEspelho;
end;

procedure TImpressaoTextoPDV.GereCabec;
var
  s: string;
  d: TDateTime;
begin
  inherited;
  PegueLinha(CenterStr(FAppObj.Loja.Nome, NCols));
  PegueLinha(CenterStr('CNPJ.: ' + FAppObj.Loja.C, NCols));
  PegueLinha(CenterStr(FAppObj.Loja.Ender.Ender1, NCols));
  PegueLinha(CenterStr(FAppObj.Loja.Ender.Ender2, NCols));
  PegueLinha(CenterStr(FAppObj.Loja.Ender.Ender3, NCols));

  d := GetDtDoc;
  if d <> DATA_ZERADA then
  begin
    s := 'Data: ' + DateToStr(d) + '   Hora: ' + TimeToStr(d);
    PegueLinha(CenterStr(s, NCols));
  end;
  s := 'OPERADOR: ' + Usuario.NomeExib;
  PegueLinha(CenterStr(s, NCols));
  PegueLinha('');
end;

procedure TImpressaoTextoPDV.GereFim;
var
  dtAgora: TDateTime;
  s: string;
begin
  inherited;
  dtAgora := Now;

  PegueLinha(CenterStr('Gerado em ' + GetDtHString(dtAgora), NCols));
  PegueSeparador;
  s := GetEspelhoAssuntoAtual;
  FCupomEspelho.Gravar(Texto, dtAgora, s);
end;

procedure TImpressaoTextoPDV.GereTexto;
begin
  inherited;
  GereCabec;
end;

function TImpressaoTextoPDV.GetAtivo: Boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := FTerminal.ImpressoraModoEnvioId > 0;
end;

function TImpressaoTextoPDV.GetEspelhoAssuntoAtual: string;
begin
  Result := '';
end;

function TImpressaoTextoPDV.GetNCols: integer;
begin
  Result := FTerminal.ImpressoraColsQtd;
end;

procedure TImpressaoTextoPDV.PegueSeparador(pCharSeparador: Char);
var
  s: string;
begin
  s := StringOfChar(pCharSeparador, NCols);
  PegueLinha(s);
end;

end.
