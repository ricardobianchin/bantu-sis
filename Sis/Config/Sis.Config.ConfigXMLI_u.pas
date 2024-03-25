unit Sis.Config.ConfigXMLI_u;

interface

uses Sis.UI.IO.FIles.XMLI_u, Sis.Config.ConfigXMLI, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog;

type
  TConfigXMLI = class(TXMLI, IConfigXMLI)
  public
    constructor Create(pRootNodeName: string; pNomeArq: string;
      pExt: string = ''; pPasta: string = ''; pAutoCreate: boolean = false;
      pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

{ TConfigXMLI }

uses Sis.UI.IO.FIles, System.SysUtils;

constructor TConfigXMLI.Create(pRootNodeName: string;
  pNomeArq, pExt, pPasta: string; pAutoCreate: boolean;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  if pPasta = '' then
  begin
    pPasta := ParamStr(0);
    pPasta := ExtractFilePath(pPasta);
    pPasta := PastaAcima(pPasta);
    pPasta := pPasta + 'Configs\';
  end;

  if pExt = '' then
    pExt := '.xml';

  if pRootNodeName = '' then
    pRootNodeName := 'root';

  inherited Create(pRootNodeName, pNomeArq, pExt, pPasta, pAutoCreate, pProcessLog, pOutput);
end;

end.
