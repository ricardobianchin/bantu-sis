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
    procedure Gravar(pTexto: string; pDtH: TDateTime = 0; pAssunto: string = '');

    constructor Create(pPastaRaiz, pAssunto: string);
  end;

implementation

uses Sis.UI.IO.Files, System.SysUtils;

constructor TFIleRecorder.Create(pPastaRaiz, pAssunto: string);
begin
  FPastaRaiz := pPastaRaiz;
  FAssunto := pAssunto;
end;

procedure TFIleRecorder.Gravar(pTexto: string; pDtH: TDateTime; pAssunto: string);
var
  sArqNome: string;
  sAssunto: string;
  dtAgora: TDateTime;
begin
  if pDtH = 0 then
    dtAgora := Now
  else
    dtAgora :=  pDtH;

  if pAssunto = '' then
    sAssunto := FAssunto
  else
    sAssunto := 'Cupom Espelho ' + pAssunto;

  sArqNome := FPastaRaiz + DateToPath(dtAgora);
  GarantaPasta(sArqNome);

  sArqNome := sArqNome + DateTimeToNomeArq(dtAgora) + ' ' + sAssunto + '.txt';
  EscreverArquivo(pTexto, sArqNome);

  sArqNome := FPastaRaiz + 'Ultimo '+FAssunto + '.txt';
  EscreverArquivo(pTexto, sArqNome);
end;

end.
