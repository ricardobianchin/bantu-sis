unit App.UI.Form.Bas.TabSheet_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.TabSheet_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, App.AppObj, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario;

type
  TTabSheetAppBasForm = class(TTabSheetBasForm)
  private
    { Private declarations }
    FAppObj: IAppObj;
    FUsuarioLog: IUsuario;
    FDBMS: IDBMS;
    FOutput: IOutput;
    FOutputNotify: IOutput;
    FProcessLog: IProcessLog;

  protected
    function GetAppObj: IAppObj;

    property AppObj: IAppObj read GetAppObj;
    property UsuarioLog: IUsuario read FUsuarioLog;
    function GetTitulo: string; virtual; abstract;
    property Output: IOutput read FOutput;
    property OutputNotify: IOutput read FOutputNotify;
    property ProcessLog: IProcessLog read FProcessLog;
  public
    { Public declarations }
    property Titulo: string read GetTitulo;
    property DBMS: IDBMS read FDBMS;
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj);
      reintroduce; virtual;
  end;

  TFunctionTabSheetFormCreate = function(AOwner: TComponent;
    pFormClassNamesSL: TStringList; pDBMS: IDBMS; pOutput: IOutput;
    pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj)
    : TTabSheetAppBasForm;
  TFunctionTabSheetGetClassName = function: string;

  TTabSheetAppBasFormClass = class of TTabSheetAppBasForm;

var
  TabSheetAppBasForm: TTabSheetAppBasForm;

implementation

{$R *.dfm}
{ TTabSheetAppBasForm }

constructor TTabSheetAppBasForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pAppObj: IAppObj);
var
  sFormCaption: string;
  sFecharCaption: string;
begin
  inherited Create(AOwner, pFormClassNamesSL);
  FAppObj := pAppObj;
  FDBMS := pDBMS;
  FOutput := pOutput;
  FUsuarioLog := pUsuarioLog;
  FOutputNotify := pOutputNotify;
  FProcessLog := pProcessLog;

  sFormCaption := Titulo;
  sFecharCaption := 'Fechar ' { + Titulo };
  FecharAction_ActBasForm.Caption := sFecharCaption;
end;

function TTabSheetAppBasForm.GetAppObj: IAppObj;
begin
  Result := FAppObj;
end;

end.
