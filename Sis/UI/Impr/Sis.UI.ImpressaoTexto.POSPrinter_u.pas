unit Sis.UI.ImpressaoTexto.POSPrinter_u;

interface

uses Sis.UI.ImpressaoTexto_u, System.Classes, ACBrBase, ACBrPosPrinter;

type
  TImpressaoTextoPOSPrinter = class(TImpressaoTexto)
  private
    ACBrPosPrinter1: TACBrPosPrinter;
  protected
    procedure EnvieImpressao; override;
  public
    constructor Create(pImpressoraNome: string; pUsuarioId: integer;
      pUsuarioNomeExib: string);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Vcl.Dialogs;

{ TImpressaoTextoPOSPrinter }

constructor TImpressaoTextoPOSPrinter.Create(pImpressoraNome: string;
  pUsuarioId: integer; pUsuarioNomeExib: string);
begin
  inherited Create(pImpressoraNome, pUsuarioId, pUsuarioNomeExib);
  ACBrPosPrinter1 := TACBrPosPrinter.Create(nil);

end;

destructor TImpressaoTextoPOSPrinter.Destroy;
begin
  FreeAndNil(ACBrPosPrinter1);
  inherited;
end;

procedure TImpressaoTextoPOSPrinter.EnvieImpressao;
var
  s: string;
begin
  inherited;
  // ACBrPosPrinter1.Porta := 'USB:0416, 5011';
  ACBrPosPrinter1.Porta := ImpressoraNome;

  ACBrPosPrinter1.Modelo := TACBrPosPrinterModelo.ppEscPosEpson;
  ACBrPosPrinter1.ArqLOG := '';
  ACBrPosPrinter1.LinhasBuffer := 0;
  ACBrPosPrinter1.LinhasEntreCupons := 0;
  ACBrPosPrinter1.EspacoEntreLinhas := 0;
  ACBrPosPrinter1.ColunasFonteNormal := 48;
  ACBrPosPrinter1.ControlePorta := False;
  ACBrPosPrinter1.CortaPapel := True;
  ACBrPosPrinter1.TraduzirTags := True;
  ACBrPosPrinter1.IgnorarTags := False;
  ACBrPosPrinter1.PaginaDeCodigo := TACBrPosPaginaCodigo.pc850;
  ACBrPosPrinter1.ConfigBarras.MostrarCodigo := False;
  ACBrPosPrinter1.ConfigBarras.Margem := 0;
  ACBrPosPrinter1.ConfigBarras.LarguraLinha := 0;
  ACBrPosPrinter1.ConfigBarras.Altura := 0;
  ACBrPosPrinter1.ConfigQRCode.Tipo := 2;
  ACBrPosPrinter1.ConfigQRCode.LarguraModulo := 4;
  ACBrPosPrinter1.ConfigQRCode.ErrorLevel := 0;
  ACBrPosPrinter1.ConfigLogo.KeyCode1 := 32;
  ACBrPosPrinter1.ConfigLogo.KeyCode2 := 32;
  ACBrPosPrinter1.ConfigLogo.FatorX := 1;
  ACBrPosPrinter1.ConfigLogo.FatorY := 1;
  try
    ACBrPosPrinter1.Ativar;
    try
      s := Texto+#13#10#13#10#13#10#13#10'</corte_total>';
      ACBrPosPrinter1.Buffer.Text := s;
      ACBrPosPrinter1.Imprimir;
    finally
      ACBrPosPrinter1.Desativar;
    end;
  except
    on e: exception do
      ShowMessage('Erro ao tentar imprimir: ' + e.message);
  end;
end;

end.
