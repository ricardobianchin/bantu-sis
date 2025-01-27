unit App.PDV.ImpressaoTexto_u;

interface

uses Sis.UI.ImpressaoTexto_u, App.AppObj, Sis.Terminal;

type
  TImpressaoTextoPDV = class(TImpressaoTexto)
  private
    FImpressoraNome: string;
    FAppObj: IAppObj;
    FTerminal: ITerminal;

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

  public
    // procedure Imprima; virtual;

    constructor Create(pImpressoraNome, pDocTitulo: string; pAppObj: IAppObj;
      pTerminal: ITerminal);
    // destructor Destroy; override;
  end;

implementation

uses Sis.Types.strings_u, {System.DateUtils,} System.SysUtils, Sis.Types.Dates;

{ TImpressaoTextoPDV }

constructor TImpressaoTextoPDV.Create(pImpressoraNome, pDocTitulo: string;
  pAppObj: IAppObj; pTerminal: ITerminal);
begin
  inherited Create(pImpressoraNome, pDocTitulo);
  FAppObj := pAppObj;
  FTerminal := pTerminal;
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

  d := GetDtDoc;
  s := 'Data: ' + DateToStr(d) + '   Hora: ' + TimeToStr(d);
  PegueLinha(CenterStr(s, NCols));
  PegueLinha(CenterStr('-', NCols));
end;

procedure TImpressaoTextoPDV.GereFim;
begin
  inherited;
  PegueLinha(CenterStr('Gerado em ' + GetAgoraString, NCols));
  PegueLinha(CenterStr('-', NCols));

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

end.
