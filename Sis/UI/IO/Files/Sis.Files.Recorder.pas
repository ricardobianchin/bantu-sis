unit Sis.Files.Recorder;

interface

type
  IFIleRecorder = interface(IInterface)
    ['{537FE3CC-83C0-43DF-AD64-1C29968AAFA2}']
    procedure Gravar(pTexto: string; pDtH: TDateTime = 0; pAssunto: string = '');
  end;

implementation

end.
