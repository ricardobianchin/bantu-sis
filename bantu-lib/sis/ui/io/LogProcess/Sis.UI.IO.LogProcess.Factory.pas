unit Sis.UI.IO.LogProcess.Factory;

interface

uses sis.ui.io.LogProcessRecord, sis.ui.io.LogProcess;

function LogProcessRecordCreate: ILogProcessRecord;
function LogProcessFileCreate(pAssunto: string; pPasta: string = '';
  pAcrescentaDtH: boolean = True; pDtH: TDateTime = 0;
  pExt: string = '.txt'): ILogProcess;

implementation

uses sis.ui.io.LogProcessRecord_u, sis.ui.io.LogProcessFile_u;

function LogProcessRecordCreate: ILogProcessRecord;
begin
  result := TLogProcessRecord.Create;
end;

function LogProcessFileCreate(pAssunto: string; pPasta: string = '';
  pAcrescentaDtH: boolean = True; pDtH: TDateTime = 0;
  pExt: string = '.txt'): ILogProcess;
begin
  result := TLogProcessFile.Create(pAssunto, pAcrescentaDtH, pPasta, pDtH, pExt);
end;

end.
