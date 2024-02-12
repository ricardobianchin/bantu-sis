unit App.UI.Form.Bas.TabSheet_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.TabSheet_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo, Sis.Config.SisConfig;

type
  TTabSheetAppBasForm = class(TTabSheetBasForm)
  private
    { Private declarations }
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    function GetSisConfig: ISisConfig;
  protected
    function GetAppInfo: IAppInfo;
    property AppInfo: IAppInfo read GetAppInfo;
    function GetTitulo: string; virtual; abstract;
    property SisConfig: ISisConfig read GetSisConfig;
  public
    { Public declarations }
    property Titulo: string read GetTitulo;
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pAppInfo: IAppInfo; pSisConfig: ISisConfig); reintroduce;
  end;

  TFunctionTabSheetFormCreate = function(AOwner: TComponent;
    pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig): TTabSheetAppBasForm;
  TFunctionTabSheetGetClassName = function: string;

  // TTabSheetAppBasFormClass = class of TTabSheetAppBasForm;

var
  TabSheetAppBasForm: TTabSheetAppBasForm;

implementation

{$R *.dfm}
{ TTabSheetAppBasForm }

constructor TTabSheetAppBasForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pAppInfo: IAppInfo; pSisConfig: ISisConfig);
var
  sFormCaption: string;
  sFecharCaption: string;
begin
  inherited Create(AOwner, pFormClassNamesSL);
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;

  sFormCaption := Titulo;
  sFecharCaption := 'Fechar '{ + Titulo};
  FecharAction_ActBasForm.Caption := sFecharCaption;
end;

function TTabSheetAppBasForm.GetAppInfo: IAppInfo;
begin
  Result := FAppInfo;
end;

function TTabSheetAppBasForm.GetSisConfig: ISisConfig;
begin
  Result := FSisConfig;
end;

end.
