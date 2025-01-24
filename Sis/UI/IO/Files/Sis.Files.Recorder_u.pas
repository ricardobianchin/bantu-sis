unit Sis.Files.Recorder_u;

interface

uses
  Sis.Files.Recorder;

type
  TFIleRecorder = class(TInterfacedObject, IFIleRecorder)
  private
    FPastaRaiz: string;
    FAssunto: string;

  public
    procedure Gravar(pTexto: string);

    constructor Create(pPastaRaiz, pAssunto: string);
  end;

implementation

uses Sis.UI.IO.Files, System.SysUtils;

constructor TFIleRecorder.Create(pPastaRaiz, pAssunto: string);
begin
  FPastaRaiz := pPastaRaiz;
  FAssunto := pAssunto;
end;

procedure TFIleRecorder.Gravar(pTexto: string);
var
  sArqNome: string;
  dtAgora: TDateTime;
begin
  dtAgora := Now;

  sArqNome := FPastaRaiz + DateToPath(dtAgora);
  GarantirPasta(sArqNome);

  sArqNome := sArqNome + 'Espelho ' + FAssunto + ' ' + DateToNomeArq(dtAgora) + '.txt';

  EscreverArquivo(pTexto, sArqNome);
end;

end.
