unit Sis.UI.ImpressaoTexto_u;

interface

uses Sis.UI.Impressao_u, System.Classes;

type
  TImpressaoTexto = class(TImpressao)
  private
    FLinhasSL: TStringList;
    FQtdLinsPorPag: SmallInt;
    FImpressaoDireta: Boolean;

    function GetTexto: string;
  protected
    procedure GereInicio; override;
    procedure GereFim; override;
    // P: TProcedureStringOfObject;
    procedure PegueLinha(pFrase: string);
    property Texto: string read GetTexto;

    function GetImpressaoDireta: Boolean;
    property ImpressaoDireta: Boolean read FImpressaoDireta;

    procedure EnvieImpressao; override;
  public
    constructor Create(pImpressoraNome: string; pUsuarioId: integer; pUsuarioNomeExib: string; pImpressaoDireta: Boolean);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.Win.Utils.Printer_u;

{ TImpressaoTexto }

constructor TImpressaoTexto.Create(pImpressoraNome: string; pUsuarioId: integer; pUsuarioNomeExib: string; pImpressaoDireta: Boolean);
begin
  inherited Create(pImpressoraNome, pUsuarioId, pUsuarioNomeExib);
  FLinhasSL := TStringList.Create;
  FQtdLinsPorPag := 0; // zero = infinitas linhas, impressao em bobina
  FImpressaoDireta := pImpressaoDireta;
end;

destructor TImpressaoTexto.Destroy;
begin
  FreeAndNil(FLinhasSL);
  inherited;
end;

procedure TImpressaoTexto.EnvieImpressao;
begin
  inherited;
  if ImpressaoDireta then
  begin
    ImprimaDireta(ImpressoraNome, Texto);
  end
  else
  begin
    ImprimaWinSpool(ImpressoraNome, GetDocTitulo, Texto);
  end;
end;

procedure TImpressaoTexto.GereFim;
begin
end;

procedure TImpressaoTexto.GereInicio;
begin
  inherited;
  FLinhasSL.Clear;
end;

function TImpressaoTexto.GetImpressaoDireta: Boolean;
begin
  Result := FImpressaoDireta;
end;

function TImpressaoTexto.GetTexto: string;
begin
  Result := FLinhasSL.Text;
end;

procedure TImpressaoTexto.PegueLinha(pFrase: string);
begin
  FLinhasSL.Add(pFrase);
end;

end.
