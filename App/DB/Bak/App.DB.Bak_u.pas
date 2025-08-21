unit App.DB.Bak_u;

interface

uses Sis.Sis.Executavel_u, App.DB.Bak, Sis.UI.IO.Output, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, System.Classes, App.AppObj;
const
{$IFDEF DEBUG}
//  FAZ_BACKUP = TRUE;
  FAZ_BACKUP = FALSE;
{$ELSE}
  FAZ_BACKUP = TRUE;
{$ENDIF}

type
  TAppBak = class(TExecutavel, IAppBak)
  private
    FAppObj: IAppObj;
    FDBMS: IDBMS;
    FDtHUltimo: TDateTime;
    FExecutando: Boolean;
  protected
    procedure PreenchaBancosSL(pBancosSL: TStrings); virtual; abstract;
    property AppObj: IAppObj read FAppObj;
  public
    constructor Create(pAppObj: IAppObj; pDBMS: IDBMS; pOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil);
    function Execute: Boolean; override;
  end;

implementation

uses Sis.Sis.Constants, System.DateUtils, System.SysUtils;

{ TAppBak }

constructor TAppBak.Create(pAppObj: IAppObj; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog);
begin
  inherited Create(pOutput, pProcessLog);
  FExecutando := False;
  FDBMS := pDBMS;
  FAppObj := pAppObj;
  FDtHUltimo := DATA_ZERADA;
end;

function TAppBak.Execute: Boolean;
var
  oBancosSL: TStringList;
  oArqsCriadosSL: TStringList;
begin
  Result := True;

  if not FAZ_BACKUP then
    exit;

  if FExecutando then
    exit;

  FExecutando := True;
  try
    if DaysBetween(FDtHUltimo, Now) < 1 then
      exit;

    oBancosSL := TStringList.Create;
    oArqsCriadosSL := TStringList.Create;
    try
      PreenchaBancosSL(oBancosSL);
      FDtHUltimo := Now;

      FDBMS.DoBackupNow(FDtHUltimo, oBancosSL, AppObj.AppInfo.PastaComandos,
        AppObj.AppInfo.PastaBackup, oArqsCriadosSL,
        AppObj.AppInfo.PastaToolsComprime);
    finally
      oBancosSL.Free;
      oArqsCriadosSL.Free;
    end;
  finally
    FExecutando := False;
  end;
end;

end.
