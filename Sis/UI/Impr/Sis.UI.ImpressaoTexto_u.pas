unit Sis.UI.ImpressaoTexto_u;

interface

uses Sis.UI.Impressao_u, System.Classes{, Sis.Types};

type
  TImpressaoTexto = class(TImpressao)
  private
    FSL: TStringList;
    FDocTitulo: string;
    FQtdLinsPorPag: SmallInt;
  protected
    procedure GereInicio; override;
    procedure GereFim; override;
    procedure EnvieImpressao; override;
//    P: TProcedureStringOfObject;
    procedure PegueLinha(pFrase: string);
  public
    constructor Create(pImpressoraNome, pDocTitulo: string);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.Win.Utils.Printer_u, Sis.Types.Dates;

{ TImpressaoTexto }

constructor TImpressaoTexto.Create(pImpressoraNome, pDocTitulo: string);
begin
  inherited Create(pImpressoraNome);
  FDocTitulo := pDocTitulo;
  FSL := TStringList.Create;
  FQtdLinsPorPag := 0; //zero = infinitas linhas, impressao em bobina
end;

destructor TImpressaoTexto.Destroy;
begin
  FreeAndNil(FSL);
  inherited;
end;

procedure TImpressaoTexto.EnvieImpressao;
begin
  inherited;
  ImprimaWinSpool(ImpressoraNome, FDocTitulo, FSL.Text);
end;

procedure TImpressaoTexto.GereFim;
begin
  inherited;
  PegueLinha('Gerado em '+GetAgoraString);
end;

procedure TImpressaoTexto.GereInicio;
begin
  inherited;
  FSL.Clear;
end;

procedure TImpressaoTexto.PegueLinha(pFrase: string);
begin
  FSL.Add(pFrase);
end;

end.
