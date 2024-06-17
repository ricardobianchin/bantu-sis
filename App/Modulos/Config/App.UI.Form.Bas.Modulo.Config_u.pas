unit App.UI.Form.Bas.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.UI.FormCreator,
  Sis.DB.DBTypes, App.DB.Utils, Sis.DB.Factory, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, Sis.ModuloSistema, App.Sessao.Eventos, App.Constants,
  Sis.Usuario, App.AppObj, Sis.UI.Controls.Utils, App.DB.Import.Form_u,
  Sis.Types.Contador;

type
  TConfigModuloBasForm = class(TModuloBasForm)
    TopoPanel: TPanel;
    ConfigActionList: TActionList;
    MenuPageControl: TPageControl;
    ConfigImportTabSheet: TTabSheet;
    DBImportOrigemComboBox: TComboBox;
    ImportOrigemTitLabel: TLabel;
    ConfigDBImportButton: TButton;
    ConfigDBImportAbrirAction: TAction;
    ConfigAmbienteTabSheet: TTabSheet;
    ConfigAmbienteToolBar: TToolBar;
    ConfigAmbienteLojasToolButton: TToolButton;
    ConfigTerminaisToolButton: TToolButton;
    ConfigAmbiLojasAction: TAction;
    ConfigTerminaisAction: TAction;
    PageControl1: TPageControl;
    BalloonHint1: TBalloonHint;

    procedure ShowTimer_BasFormTimer(Sender: TObject);

    // ambiente
    procedure ConfigAmbiLojasActionExecute(Sender: TObject);

    // dbimport
    procedure ConfigDBImportAbrirActionExecute(Sender: TObject);
  private
    { Private declarations }
    FFormClassNamesSL: TStringList;
    FContador: IContador;
    FOutputNotify: IOutput;

    FAmbiLojasDataSetFormCreator: IFormCreator;

    procedure TabSheetCrie(pFormCreator: IFormCreator);
  protected
    procedure DBImportPrep; virtual;
    function DBImportFormCreate(pItemIndex: integer): TDBImportForm;
      virtual; abstract;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppObj: IAppObj);
  end;

var
  ConfigModuloBasForm: TConfigModuloBasForm;

implementation

{$R *.dfm}

uses Sis.Types.Factory, Sis.UI.IO.Factory, App.AppInfo, Sis.Config.SisConfig,
  App.Pess.UI.Factory_u;

{ TConfigModuloBasForm }

constructor TConfigModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj);
var
  oAppInfo: IAppInfo;
  oSisConfig: ISisConfig;
begin
  inherited Create(AOwner, pModuloSistema, pSessaoEventos, pSessaoIndex,
    pUsuario, pAppObj);
  DBImportPrep;
  FFormClassNamesSL := TStringList.Create;

  FContador := ContadorCreate;
  FOutputNotify := BalloonHintOutputCreate(BalloonHint1);

  FAmbiLojasDataSetFormCreator := AmbiLojaDataSetFormCreatorCreate
    (FFormClassNamesSL, AppInfo, SisConfig, Usuario, DBMS, Output, ProcessLog,
    FOutputNotify);

{$IFDEF DEBUG}
  MenuPageControl.ActivePageIndex := 0;
{$ELSE}
  MenuPageControl.ActivePageIndex := 0;
{$ENDIF}
end;

procedure TConfigModuloBasForm.ConfigAmbiLojasActionExecute(Sender: TObject);
begin
  inherited;
  TabSheetCrie(FAmbiLojasDataSetFormCreator);
end;

procedure TConfigModuloBasForm.ConfigDBImportAbrirActionExecute
  (Sender: TObject);
var
  iItemIndex: integer;
  iSelectedImportIndex: integer;
  oDBImportForm: TDBImportForm;
begin
  inherited;
  ConfigDBImportAbrirAction.Enabled := False;
  try
    oDBImportForm := DBImportFormCreate(DBImportOrigemComboBox.ItemIndex);
    oDBImportForm.ShowModal;
  finally
    ConfigDBImportAbrirAction.Enabled := True;
  end;
end;

procedure TConfigModuloBasForm.DBImportPrep;
begin
  DBImportOrigemComboBox.Text := '';
  DBImportOrigemComboBox.Clear;
end;

procedure TConfigModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);
  if AppObj.AppTestesConfig.ModuConfAmbiLojaAutoExec then
    ConfigAmbiLojasAction.Execute;
end;

procedure TConfigModuloBasForm.TabSheetCrie(pFormCreator: IFormCreator);
var
  oTabSheet: TTabSheet;
  oForm: TForm;
  sFormClassName: string;
  iExistenteIndex: integer;

  oFormOwner: TComponent;
  oAppInfo: IAppInfo;
  oSisConfig: ISisConfig;
begin
  sFormClassName := pFormCreator.FormClassName;

  iExistenteIndex := FFormClassNamesSL.IndexOf(sFormClassName);
  if iExistenteIndex > -1 then
  begin
    oTabSheet := TTabSheet(FFormClassNamesSL.Objects[iExistenteIndex]);
    PageControl1.ActivePage := oTabSheet;
    FOutputNotify.Exibir('Opção já aberta');
    exit;
  end;

  oTabSheet := TTabSheet.Create(PageControl1);
  oTabSheet.PageControl := PageControl1;
  oTabSheet.Name := sFormClassName + 'TabSheet';
  PageControl1.ActivePage := oTabSheet;

  oFormOwner := oTabSheet;

  oAppInfo := AppInfo;
  oSisConfig := SisConfig;

  oForm := pFormCreator.FormCreate(oFormOwner);
  oForm.Parent := oTabSheet;

  FFormClassNamesSL.AddObject(sFormClassName, oTabSheet);

  oTabSheet.Caption := pFormCreator.Titulo;

  ClearStyleElements(oTabSheet);

  oForm.Show;
end;

end.
