unit App.UI.FormCreator.DataSet_u;

interface

uses VCL.Forms, App.UI.Form.Bas.TabSheet.DataSet_u, System.Classes, App.AppInfo,
  Sis.Config.SisConfig, Sis.DB.DBTypes, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, App.Ent.Ed, App.Ent.DBI,
  App.UI.Form.Bas.TabSheet_u, App.UI.FormCreator.TabSheet_u, Sis.Types.Utils_u;

type
  TDataSetFormCreator = class(TTabSheetFormCreator)
  private
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;

    function GetDataSetFormClass: TTabSheetDataSetBasFormClass;
    property DataSetFormClass: TTabSheetDataSetBasFormClass
      read GetDataSetFormClass;

  protected
    function GetTitulo: string; override;

  public
    function FormCreate(AOwner: TComponent): TForm; override;
    function FormCreateSelect(AOwner: TComponent; pIdPos: integer): TForm; override;
    constructor Create(pFormClass: TTabSheetDataSetBasFormClass;
      pFormClassNamesSL: TStringList; pAppInfo: IAppInfo;
      pSisConfig: ISisConfig; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI); reintroduce;
    function PergSelect(var pSelectItem: TSelectItem): boolean; override;
  end;

implementation

uses VCL.Controls;

{ TDataSetFormCreator }

constructor TDataSetFormCreator.Create(pFormClass: TTabSheetDataSetBasFormClass;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput; pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(pFormClass, pFormClassNamesSL, pAppInfo, pSisConfig, pDBMS,
    pOutput, pProcessLog, pOutputNotify);
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
end;

function TDataSetFormCreator.FormCreate(AOwner: TComponent): TForm;
begin
  Result := DataSetFormClass.Create(AOwner, FormClassNamesSL, AppInfo,
    SisConfig, DBMS, Output, ProcessLog, OutputNotify, FEntEd, FEntDBI,
    mfBrowse, 0);
end;

function TDataSetFormCreator.FormCreateSelect(AOwner: TComponent; pIdPos: integer): TForm;
begin
  Result := DataSetFormClass.Create(AOwner, FormClassNamesSL, AppInfo,
    SisConfig, DBMS, Output, ProcessLog, OutputNotify, FEntEd, FEntDBI,
    mfSelect, pIdPos);
end;

function TDataSetFormCreator.GetDataSetFormClass: TTabSheetDataSetBasFormClass;
begin
  Result := TTabSheetDataSetBasFormClass(FormClass);
end;

function TDataSetFormCreator.GetTitulo: string;
begin
  Result := FEntEd.Titulo;
end;

function TDataSetFormCreator.PergSelect(var pSelectItem: TSelectItem): boolean;
var
  oForm: TTabSheetDataSetBasForm;
begin
  oForm := TTabSheetDataSetBasForm(FormCreateSelect(nil, pSelectItem.Id));
  try
    Result := IsPositiveResult(oForm.ShowModal);
    if Result then
      pSelectItem := oForm.GetSelectItem;
  finally
    oForm.Free;
  end;
end;

end.
