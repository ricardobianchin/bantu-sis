unit App.UI.FormCreator.TabSheet_u;

interface

uses Sis.UI.FormCreator_u, VCL.Forms, App.UI.Form.Bas.TabSheet_u,
  System.Classes, App.AppInfo, Sis.Config.SisConfig, Sis.DB.DBTypes
  , Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TTabSheetFormCreator = class(TFormCreator)
  private
    FFormClassNamesSL: TStringList;
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FDBMS: IDBMS;
    FOutput: IOutput;
    FProcessLog: IProcessLog;
    FOutputNotify: IOutput;

    function GetFormClassNamesSL: TStringList;
    function GetAppInfo: IAppInfo;
    function GetSisConfig: ISisConfig;
    function GetDBMS: IDBMS;
    function GetOutput: IOutput;
    function GetProcessLog: IProcessLog;
    function GetOutputNotify: IOutput;

    function GetTabSheetFormClass: TTabSheetAppBasFormClass;
    property TabSheetFormClass: TTabSheetAppBasFormClass read GetTabSheetFormClass;

  protected
    property FormClassNamesSL: TStringList read GetFormClassNamesSL;
    property AppInfo: IAppInfo read GetAppInfo;
    property SisConfig: ISisConfig read GetSisConfig;
    property DBMS: IDBMS read GetDBMS;
    property Output: IOutput read GetOutput;
    property ProcessLog: IProcessLog read GetProcessLog;
    property OutputNotify: IOutput read GetOutputNotify;

  public
    function FormCreate(AOwner: TComponent): TForm; override;
    constructor Create(pFormClass: TTabSheetAppBasFormClass;
      pFormClassNamesSL: TStringList; pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput); reintroduce;
  end;

implementation

{ TTabSheetFormCreator }

constructor TTabSheetFormCreator.Create(pFormClass: TTabSheetAppBasFormClass;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput);
begin
  inherited Create(pFormClass);
  FFormClassNamesSL := pFormClassNamesSL;
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;
  FDBMS := pDBMS;
  FOutput := pOutput;
  FProcessLog := pProcessLog;
  FOutputNotify := pOutputNotify;
end;

function TTabSheetFormCreator.FormCreate(AOwner: TComponent): TForm;
begin
  Result := TabSheetFormClass.Create(AOwner, FormClassNamesSL, FAppInfo,
    FSisConfig, FDBMS, FOutput, FProcessLog, FOutputNotify);
end;

function TTabSheetFormCreator.GetAppInfo: IAppInfo;
begin
  Result := FAppInfo;
end;

function TTabSheetFormCreator.GetDBMS: IDBMS;
begin
  Result := FDBMS;
end;

function TTabSheetFormCreator.GetFormClassNamesSL: TStringList;
begin
  Result := FFormClassNamesSL;
end;

function TTabSheetFormCreator.GetOutput: IOutput;
begin
  Result := FOutput;
end;

function TTabSheetFormCreator.GetOutputNotify: IOutput;
begin
  Result := FOutputNotify;
end;

function TTabSheetFormCreator.GetProcessLog: IProcessLog;
begin
  Result := FProcessLog;
end;

function TTabSheetFormCreator.GetSisConfig: ISisConfig;
begin
  Result := FSisConfig;
end;

function TTabSheetFormCreator.GetTabSheetFormClass: TTabSheetAppBasFormClass;
begin
  Result := TTabSheetAppBasFormClass(FormClass);
end;

end.
