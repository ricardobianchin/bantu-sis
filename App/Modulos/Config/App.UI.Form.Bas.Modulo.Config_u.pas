unit App.UI.Form.Bas.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Menus, Sis.DB.Import.Origem, Sis.DB.DBTypes, App.DB.Utils, Sis.DB.Factory,
  Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, Sis.DB.Import;

type
  TConfigModuloBasForm = class(TModuloBasForm)
    TopoPanel: TPanel;
    MenuPageControl: TPageControl;
    ImportTabSheet: TTabSheet;
    DBImportOrigemComboBox: TComboBox;
    ImportOrigemTitLabel: TLabel;
    DBImportButton: TButton;
    ConfigActionList: TActionList;
    DBImportAction: TAction;
    procedure DBImportActionExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DBImportPrep; virtual;
    function DBImportOrigemCreate(pItemIndex: integer): IDBImportOrigem; virtual; abstract;
    function DBImportCreate(pDestinoDBConnection: IDBConnection;
      pDBImportOrigem: IDBImportOrigem; pOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil): IDBImport; virtual; abstract;
  public
    { Public declarations }
  end;

var
  ConfigModuloBasForm: TConfigModuloBasForm;

implementation

{$R *.dfm}

{ TConfigModuloBasForm }

procedure TConfigModuloBasForm.DBImportActionExecute(Sender: TObject);
var
  iItemIndex: integer;
  iSelectedImportIndex: integer;
  oDBImport: IDBImport;
  oDBImportOrigem: IDBImportOrigem;
  oDBConnectionParams: TDBConnectionParams;
  oDBConnectionDestino: IDBConnection;
begin
  inherited;
  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oDBConnectionDestino := DBConnectionCreate('Config.Import.Destino.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  iItemIndex := DBImportOrigemComboBox.ItemIndex;
  oDBImportOrigem := DBImportOrigemCreate(iItemIndex);
  oDBImport := DBImportCreate(oDBConnectionDestino, oDBImportOrigem, Output, ProcessLog);

  oDBImport.Execute;
end;

procedure TConfigModuloBasForm.DBImportPrep;
begin
  DBImportOrigemComboBox.Text := '';
  DBImportOrigemComboBox.Clear;
end;

end.
