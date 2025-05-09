unit App.UI.Form.Bas.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.UI.FormCreator,
  Sis.DB.DBTypes, App.DB.Utils, Sis.DB.Factory, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, Sis.ModuloSistema, App.Sessao.EventosDeSessao,
  App.Constants,
  Sis.Usuario, App.AppObj, Sis.UI.Controls.Utils, App.DB.Import.Form_u,
  Sis.Types.Contador, Sis.Entities.Types;

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
    ConfigTarefasTabSheet: TTabSheet;
    ConfigBackupAgoraButton: TButton;

    procedure ShowTimer_BasFormTimer(Sender: TObject);

    // dbimport
    procedure ConfigDBImportAbrirActionExecute(Sender: TObject);
    procedure ConfigAmbiLojasActionExecute(Sender: TObject);
    procedure ConfigTerminaisActionExecute(Sender: TObject);
    procedure ConfigBackupAgoraButtonClick(Sender: TObject);
  private
    { Private declarations }
    FFormClassNamesSL: TStringList;
    FContador: IContador;
    FOutputNotify: IOutput;

    FAmbiLojasDataSetFormCreator: IFormCreator;
    FAmbiTerminalDataSetFormCreator: IFormCreator;

    procedure TabSheetCrie(pFormCreator: IFormCreator);
  protected
    procedure DBImportPrep; virtual;
    function DBImportFormCreate(pItemIndex: integer): TDBImportForm;
      virtual; abstract;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
  end;

var
  ConfigModuloBasForm: TConfigModuloBasForm;

implementation

{$R *.dfm}

uses Sis.Types.Factory, Sis.UI.IO.Factory, App.AppInfo, Sis.Config.SisConfig,
  App.Pess.UI.Factory_u, App.Config.Ambi.Factory_u, Sis.Terminal,
  Sis.Sis.Constants, App.UI.Form.Config.Tar.Backup.Message_u;

{ TConfigModuloBasForm }

constructor TConfigModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
var
  oAppInfo: IAppInfo;
  oSisConfig: ISisConfig;
begin
  inherited Create(AOwner, pModuloSistema, pEventosDeSessao, pSessaoIndex,
    pUsuario, pAppObj, pTerminalId);
  DBImportPrep;
  FFormClassNamesSL := TStringList.Create;

  FContador := ContadorCreate;
  FOutputNotify := BalloonHintOutputCreate(BalloonHint1);

  FAmbiLojasDataSetFormCreator := AmbiLojaDataSetFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);

  FAmbiTerminalDataSetFormCreator := TerminalFormCreatorCreate
    (FFormClassNamesSL, LogUsuario, DBMS, Output, ProcessLog,
    FOutputNotify, AppObj);

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

procedure TConfigModuloBasForm.ConfigBackupAgoraButtonClick(Sender: TObject);
var
  dtAgora: TDateTime;
  sNomeArqCriado: string;
  oTerminal: ITerminal;
  oNomesFDBSL: TStringList;
  oNomesFBKSL: TStringList;
  oDBConnectionParams: TDBConnectionParams;
begin
  inherited;
  dtAgora := now;

  oNomesFDBSL := TStringList.Create;
  oNomesFBKSL := TStringList.Create;
  try
    // pega nomearqs terminais
    AppObj.TerminalList.ExecuteForAll(
      procedure(pTerminal: ITerminal)
      begin
        oNomesFDBSL.Add(pTerminal.LocalArqDados);
      end, AppObj.SisConfig.LocalMachineId.Name);

    if AppObj.SisConfig.LocalMachineIsServer then
    begin
      oDBConnectionParams := TerminalIdToDBConnectionParams
        (TERMINAL_ID_RETAGUARDA, AppObj);

      oNomesFDBSL.Add(oDBConnectionParams.Arq);
    end;

    DBMS.DoBackupNow(dtAgora, oNomesFDBSL, AppObj.AppInfo.PastaComandos,
      AppObj.AppInfo.PastaBackup, oNomesFBKSL, AppObj.AppInfo.PastaToolsComprime);

    BakMessageExibir(oNomesFBKSL);
  finally
    oNomesFDBSL.Free;
    oNomesFBKSL.Free;
  end;
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

procedure TConfigModuloBasForm.ConfigTerminaisActionExecute(Sender: TObject);
begin
  inherited;
  TabSheetCrie(FAmbiTerminalDataSetFormCreator);
end;

procedure TConfigModuloBasForm.DBImportPrep;
begin
  DBImportOrigemComboBox.Text := '';
  DBImportOrigemComboBox.Clear;
end;

procedure TConfigModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
var
  i: integer;
  sText: string;
begin
  inherited;
  ClearStyleElements(Self);
  if AppObj.AppTestesConfig.ModuConf.Ambi.Loja.AutoExec then
    ConfigAmbiLojasAction.Execute;

  if AppObj.AppTestesConfig.ModuConf.Import.AutoExec then
  begin
    MenuPageControl.ActivePage := ConfigImportTabSheet;

    sText := DBImportOrigemComboBox.Text;
    i := DBImportOrigemComboBox.Items.IndexOf(sText);
    if i >= 0 then
    begin
      DBImportOrigemComboBox.ItemIndex := i;
      ConfigDBImportAbrirAction.Execute;
    end;
  end;

  // ConfigTerminaisAction.Execute;
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
    FOutputNotify.Exibir('Op��o j� aberta');
    exit;
  end;

  oTabSheet := TTabSheet.Create(PageControl1);
  oTabSheet.PageControl := PageControl1;
  oTabSheet.Name := sFormClassName + 'TabSheet';
  PageControl1.ActivePage := oTabSheet;

  oFormOwner := oTabSheet;

  oForm := pFormCreator.FormCreate(oFormOwner);
  oForm.Parent := oTabSheet;

  FFormClassNamesSL.AddObject(sFormClassName, oTabSheet);

  oTabSheet.Caption := pFormCreator.Titulo;

  ClearStyleElements(oTabSheet);

  oForm.Show;
end;

end.
