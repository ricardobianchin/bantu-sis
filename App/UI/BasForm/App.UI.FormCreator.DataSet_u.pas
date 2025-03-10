unit App.UI.FormCreator.DataSet_u;

interface

uses VCL.Forms, App.UI.Form.Bas.TabSheet.DataSet_u, System.Classes, App.AppObj,
  App.AppInfo,
  Sis.Config.SisConfig, Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.Usuario,
  Sis.UI.IO.Output.ProcessLog, App.Ent.Ed, App.Ent.DBI,
  App.UI.Form.Bas.TabSheet_u, App.UI.FormCreator.TabSheet_u, Sis.Types,
  App.UI.TabSheet.DataSet.Types_u;

type
  TDataSetFormCreator = class(TTabSheetFormCreator)
  private
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;

    function GetDataSetFormClass: TTabSheetDataSetBasFormClass;
    property DataSetFormClass: TTabSheetDataSetBasFormClass
      read GetDataSetFormClass;

  public
    function FormCreate(AOwner: TComponent): TForm; override;
    function FormCreateSelect(AOwner: TComponent; pIdPos: integer)
      : TForm; override;
    constructor Create(pFormClass: TTabSheetDataSetBasFormClass;
      pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
      pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
      pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj); reintroduce;
    function PergSelect(var pSelectItem: TSelectItem): boolean; override;
  end;

implementation

uses VCL.Controls;

{ TDataSetFormCreator }

constructor TDataSetFormCreator.Create(pFormClass: TTabSheetDataSetBasFormClass;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pAppObj: IAppObj);
var
  sTitulo: string;
begin
  sTitulo := pEntEd.Titulo;
  inherited Create(pFormClass, sTitulo, pFormClassNamesSL, pUsuarioLog,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pAppObj);
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
end;

function TDataSetFormCreator.FormCreate(AOwner: TComponent): TForm;
begin
  Result := DataSetFormClass.Create(AOwner, FormClassNamesSL,
    UsuarioLog, DBMS, Output, ProcessLog, OutputNotify, FEntEd, FEntDBI,
    mdfBrowse, 0, AppObj);
end;

function TDataSetFormCreator.FormCreateSelect(AOwner: TComponent;
  pIdPos: integer): TForm;
begin
  Result := DataSetFormClass.Create(AOwner, FormClassNamesSL,
    UsuarioLog, DBMS, Output, ProcessLog, OutputNotify, FEntEd, FEntDBI,
    mdfSelect, pIdPos, AppObj);
end;

function TDataSetFormCreator.GetDataSetFormClass: TTabSheetDataSetBasFormClass;
begin
  Result := TTabSheetDataSetBasFormClass(FormClass);
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
