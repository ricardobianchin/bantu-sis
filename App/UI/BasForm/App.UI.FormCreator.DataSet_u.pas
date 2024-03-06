unit App.UI.FormCreator.DataSet_u;

interface

uses Sis.UI.FormCreator_u, VCL.Forms, App.UI.Form.Bas.TabSheet.DataSet_u,
  System.Classes, App.AppInfo, Sis.Config.SisConfig,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.Ent.Ed,
  App.Ent.DBI;

type
  TDataSetFormCreator = class(TFormCreator)
  private
    FFormClassNamesSL: TStringList;
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FDBMS: IDBMS;
    FOutput: IOutput;
    FProcessLog: IProcessLog;
    FOutputNotify: IOutput;
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;

    function GetDataSetFormClass: TTabSheetDataSetBasFormClass;
    property DataSetFormClass: TTabSheetDataSetBasFormClass
      read GetDataSetFormClass;

  protected
    function GetTitulo: string; override;

  public
    function FormCreate(AOwner: TComponent): TForm; override;
    constructor Create(pFormClass: TTabSheetDataSetBasFormClass;
      pFormClassNamesSL: TStringList; pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI); reintroduce;
  end;

implementation

{ TDataSetFormCreator }

constructor TDataSetFormCreator.Create(pFormClass: TTabSheetDataSetBasFormClass;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(pFormClass);
  FFormClassNamesSL := pFormClassNamesSL;
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;
  FDBMS := pDBMS;
  FOutput := pOutput;
  FProcessLog := pProcessLog;
  FOutputNotify := pOutputNotify;
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
end;

function TDataSetFormCreator.FormCreate(AOwner: TComponent): TForm;
begin
  Result := DataSetFormClass.Create(AOwner, FFormClassNamesSL, FAppInfo,
    FSisConfig, FDBMS, FOutput, FProcessLog, FOutputNotify, FEntEd, FEntDBI);
end;

function TDataSetFormCreator.GetDataSetFormClass: TTabSheetDataSetBasFormClass;
begin
  Result := TTabSheetDataSetBasFormClass(FormClass);
end;

function TDataSetFormCreator.GetTitulo: string;
begin
  Result := FEntEd.Titulo;
end;

end.
