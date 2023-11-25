unit ShopApp.ShopAppObj_u;

interface

uses ShopApp.ShopAppObj, App.AppObj, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog;

type
  TShopAppObj = class(TInterfacedObject, IShopAppObj)
  private
    FAppObj: IAppObj;

    FStatusOutput: IOutput;
    FProcessOutput: IOutput;
    FProcessLog: IProcessLog;
  public
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessOutput: IOutput read FProcessOutput;
    property ProcessLog: IProcessLog read FProcessLog;

    procedure Inicialize;
    constructor Create(pAppObj: IAppObj;
      pStatusOutput: IOutput;
      pProcessOutput: IOutput;
      pProcessLog: IProcessLog
      );
  end;

implementation

{ TShopAppObj }

constructor TShopAppObj.Create(pAppObj: IAppObj;
      pStatusOutput: IOutput;
      pProcessOutput: IOutput;
      pProcessLog: IProcessLog
      );
begin
  FStatusOutput := pStatusOutput;
  FProcessOutput := pProcessOutput;
  FProcessLog := pProcessLog;

  FAppObj := pAppObj;
  ProcessLog.RegistreLog('Create');
  ProcessLog.PegueLocal('TAppObj.Create');

end;

procedure TShopAppObj.Inicialize;
begin
  FAppObj.Inicialize;
end;

end.
