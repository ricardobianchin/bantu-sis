unit App.PDV.ImpressaoTexto_u;

interface

uses Sis.UI.ImpressaoTexto_u, App.AppObj, Sis.Terminal, App.PDV.CupomEspelho;

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

    // procedure GereInicio; override;
    procedure GereCabec; override;
    procedure GereFim; override;
    // procedure EnvieImpressao; override;
    procedure GereTexto; override;
    procedure PegueSeparador(pCharSeparador: Char = '-');

  public
    // procedure Imprima; virtual;

    constructor Create(pImpressoraNome: string; pAppObj: IAppObj;
      pTerminal: ITerminal; pCupomEspelho: ICupomEspelho);
    // destructor Destroy; override;
  end;

implementation

uses Sis.Types.strings_u, {System.DateUtils,} System.SysUtils, Sis.Types.Dates;

{ TImpressaoTextoPDV }

constructor TImpressaoTextoPDV.Create(pImpressoraNome: string;
  pAppObj: IAppObj; pTerminal: ITerminal; pCupomEspelho: ICupomEspelho);
begin
  inherited Create(pImpressoraNome);
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
  s := 'Data: ' + DateToStr(d) + '   Hora: ' + TimeToStr(d);
  PegueLinha(CenterStr(s, NCols));
  PegueSeparador;
end;

procedure TImpressaoTextoPDV.GereFim;
var
  dtAgora: TDateTime;
begin
  inherited;
  dtAgora := Now;

  PegueLinha(CenterStr('Gerado em ' + GetDtHString(dtAgora), NCols));
  PegueSeparador;
  FCupomEspelho.Gravar(Texto, dtAgora);
end;

procedure TImpressaoTextoPDV.GereTexto;
begin
  inherited;
  GereCabec;
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
