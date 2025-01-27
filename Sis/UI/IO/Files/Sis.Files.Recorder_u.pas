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
    procedure Gravar(pTexto: string; pDtH: TDateTime = 0);

    constructor Create(pPastaRaiz, pAssunto: string);
  end;

implementation

uses Sis.UI.IO.Files, System.SysUtils;

constructor TFIleRecorder.Create(pPastaRaiz, pAssunto: string);
begin
  FPastaRaiz := pPastaRaiz;
  FAssunto := pAssunto;
end;

procedure TFIleRecorder.Gravar(pTexto: string; pDtH: TDateTime);
var
  sArqNome: string;
  dtAgora: TDateTime;
begin
  if pDtH = 0 then
    dtAgora := Now
  else
    dtAgora :=  pDtH;

  sArqNome := FPastaRaiz + DateToPath(dtAgora);
  GarantirPasta(sArqNome);

  sArqNome := sArqNome + FAssunto + ' ' + DateToNomeArq(dtAgora) + '.txt';

{$IFDEF DEBUG}
  sArqNome := FPastaRaiz + 'Espelho.txt';
{$ENDIF}


  EscreverArquivo(pTexto, sArqNome);
end;

end.
