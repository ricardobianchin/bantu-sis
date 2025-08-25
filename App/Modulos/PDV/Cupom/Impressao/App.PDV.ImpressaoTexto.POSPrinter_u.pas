unit App.PDV.ImpressaoTexto.POSPrinter_u;

interface

uses Sis.UI.ImpressaoTexto.POSPrinter_u, App.AppObj, Sis.Terminal, App.PDV.CupomEspelho,
  Sis.Sis.Constants;

type
  TImpressaoTextoPOSPrinterPDV = class(TImpressaoTextoPOSPrinter)
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

    procedure GereTexto; override;
    procedure PegueSeparador(pCharSeparador: Char = '-');
    function GetEspelhoAssuntoAtual: string; virtual;

  public
    constructor Create(pImpressoraNome: string; pUsuarioId: integer; pUsuarioNomeExib: string;
      pAppObj: IAppObj; pTerminal: ITerminal; pCupomEspelho: ICupomEspelho);
  end;

implementation

uses Sis.Types.strings_u, {System.DateUtils,} System.SysUtils, Sis.Types.Dates;

{ TImpressaoTextoPOSPrinterPDV }

constructor TImpressaoTextoPOSPrinterPDV.Create(pImpressoraNome: string;
  pUsuarioId: integer; pUsuarioNomeExib: string; pAppObj: IAppObj;
  pTerminal: ITerminal; pCupomEspelho: ICupomEspelho);
begin
  inherited Create(pImpressoraNome, pUsuarioId, pUsuarioNomeExib);
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FCupomEspelho := pCupomEspelho;
end;

procedure TImpressaoTextoPOSPrinterPDV.GereCabec;
var
  s: string;
  d: TDateTime;
begin
  inherited;
  PegueLinha('</ce>'+FAppObj.Loja.NomeFantasia);
  //PegueLinha('</ce>'+'CNPJ.: ' + FAppObj.Loja.C);
  PegueLinha('</ce>'+FAppObj.Loja.Ender.Ender1);
  //PegueLinha('</ce>'+FAppObj.Loja.Ender.Ender2);
  PegueLinha('</ce>'+FAppObj.Loja.Ender.Ender3);

  s := 'LJ: '+FAppObj.Loja.Id.ToString;
  d := GetDtDoc;
  if d <> DATA_ZERADA then
  begin
    s := s + ' '+FormatDateTime('ddd dd/mmm/yy-hh:nn', d)+'H';
//    s := 'Data: ' + DateToStr(d) + '   Hora: ' + TimeToStr(d);
//    PegueLinha('</ce>'+s);
  end;
  s := s + ' Opr.: ' + UsuarioId.ToString;
  PegueLinha('</ce>'+s);
//  PegueLinha('');
end;

procedure TImpressaoTextoPOSPrinterPDV.GereFim;
var
  dtAgora: TDateTime;
  s: string;
begin
  inherited;
  dtAgora := Now;

  PegueLinha('</ce>'+'Gerado em ' + GetDtHString(dtAgora));
  PegueSeparador;
  s := GetEspelhoAssuntoAtual;
  FCupomEspelho.Gravar(Texto, dtAgora, s);
end;

procedure TImpressaoTextoPOSPrinterPDV.GereTexto;
begin
  inherited;
  GereCabec;
end;

function TImpressaoTextoPOSPrinterPDV.GetAtivo: Boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := FTerminal.ImpressoraModoEnvioId > 0;
end;

function TImpressaoTextoPOSPrinterPDV.GetEspelhoAssuntoAtual: string;
begin
  Result := '';
end;

function TImpressaoTextoPOSPrinterPDV.GetNCols: integer;
begin
  Result := FTerminal.ImpressoraColsQtd;
end;

procedure TImpressaoTextoPOSPrinterPDV.PegueSeparador(pCharSeparador: Char);
var
  s: string;
begin
  s := StringOfChar(pCharSeparador, NCols);
  PegueLinha(s);
end;

end.
