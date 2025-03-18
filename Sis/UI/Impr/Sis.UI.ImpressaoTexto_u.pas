unit Sis.UI.ImpressaoTexto_u;

interface

uses Sis.UI.Impressao_u, System.Classes;

type
  TImpressaoTexto = class(TImpressao)
  private
    FLinhasSL: TStringList;
    FQtdLinsPorPag: SmallInt;

    function GetTexto: string;
  protected
    procedure GereInicio; override;
    procedure GereFim; override;
    procedure EnvieImpressao; override;
    // P: TProcedureStringOfObject;
    procedure PegueLinha(pFrase: string);
    property Texto: string read GetTexto;
  public
    constructor Create(pImpressoraNome: string; pUsuarioId: integer; pUsuarioNomeExib: string);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.Win.Utils.Printer_u;

{ TImpressaoTexto }

constructor TImpressaoTexto.Create(pImpressoraNome: string; pUsuarioId: integer; pUsuarioNomeExib: string);
begin
  inherited Create(pImpressoraNome, pUsuarioId, pUsuarioNomeExib);
  FLinhasSL := TStringList.Create;
  FQtdLinsPorPag := 0; // zero = infinitas linhas, impressao em bobina
end;

destructor TImpressaoTexto.Destroy;
begin
  FreeAndNil(FLinhasSL);
  inherited;
end;

procedure TImpressaoTexto.EnvieImpressao;
begin
  inherited;
  ImprimaWinSpool(ImpressoraNome, GetDocTitulo, Texto);
end;

procedure TImpressaoTexto.GereFim;
begin
end;

procedure TImpressaoTexto.GereInicio;
begin
  inherited;
  FLinhasSL.Clear;
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
