unit App.UI.FormCreator.TabSheet_u;

interface

uses Sis.UI.FormCreator_u, VCL.Forms, App.UI.Form.Bas.TabSheet_u, Sis.Usuario,
  System.Classes, App.AppInfo, Sis.Config.SisConfig, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj;

type
  TTabSheetFormCreator = class(TFormCreator)
  private
    InstanciouSL: boolean;
    FFormClassNamesSL: TStringList;
    FAppObj: IAppObj;
    FDBMS: IDBMS;
    FUsuarioLog: IUsuario;
    FOutput: IOutput;
    FProcessLog: IProcessLog;
    FOutputNotify: IOutput;

    function GetFormClassNamesSL: TStringList;
    function GetAppObj: IAppObj;
    function GetDBMS: IDBMS;
    function GetOutput: IOutput;
    function GetProcessLog: IProcessLog;
    function GetOutputNotify: IOutput;

    function GetTabSheetFormClass: TTabSheetAppBasFormClass;
    property TabSheetFormClass: TTabSheetAppBasFormClass
      read GetTabSheetFormClass;

  protected
    property FormClassNamesSL: TStringList read GetFormClassNamesSL;

    property AppObj: IAppObj read GetAppObj;
    property UsuarioLog: IUsuario read FUsuarioLog;
    property DBMS: IDBMS read GetDBMS;
    property Output: IOutput read GetOutput;
    property ProcessLog: IProcessLog read GetProcessLog;
    property OutputNotify: IOutput read GetOutputNotify;

  public
    function FormCreate(AOwner: TComponent): TForm; override;
    constructor Create(pFormClass: TTabSheetAppBasFormClass; pTitulo: string;
      pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pAppObj: IAppObj); reintroduce;
    destructor Destroy; override;

  end;

implementation

{ TTabSheetFormCreator }

constructor TTabSheetFormCreator.Create(pFormClass: TTabSheetAppBasFormClass;
  pTitulo: string; pFormClassNamesSL: TStringList;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj);
begin
  inherited Create(pFormClass, pTitulo);
  InstanciouSL := not Assigned(pFormClassNamesSL);
  if InstanciouSL then
    FFormClassNamesSL := TStringList.Create
  else
    FFormClassNamesSL := pFormClassNamesSL;

  FAppObj := pAppObj;
  FUsuarioLog := pUsuarioLog;
  FDBMS := pDBMS;

  FOutput := pOutput;
  FProcessLog := pProcessLog;
  FOutputNotify := pOutputNotify;
end;

destructor TTabSheetFormCreator.Destroy;
begin
  if InstanciouSL then
    FFormClassNamesSL.Free;
  inherited;
end;

function TTabSheetFormCreator.FormCreate(AOwner: TComponent): TForm;
begin
  Result := TabSheetFormClass.Create(AOwner, FormClassNamesSL, FUsuarioLog,
    FDBMS, FOutput, FProcessLog, FOutputNotify, FAppObj);
end;

function TTabSheetFormCreator.GetAppObj: IAppObj;
begin
  Result := FAppObj;
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

function TTabSheetFormCreator.GetTabSheetFormClass: TTabSheetAppBasFormClass;
begin
  Result := TTabSheetAppBasFormClass(FormClass);
end;

end.
