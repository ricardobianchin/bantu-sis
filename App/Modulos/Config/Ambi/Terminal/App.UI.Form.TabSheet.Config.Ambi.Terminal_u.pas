unit App.UI.Form.TabSheet.Config.Ambi.Terminal_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  App.UI.Frame.DBGrid.Config.Ambi.Terminal_u, App.AppObj, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario,
  App.Config.Ambi.Terminal.DBI;

type
  TConfigAmbiTermForm = class(TTabSheetAppBasForm)
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FDBConnection: IDBConnection;
    FTermDBI: IConfigAmbiTerminalDBI;
    FTerminaisDBGridFrame: TTerminaisDBGridFrame;
  protected
    function GetTitulo: string; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pAppObj: IAppObj);
      reintroduce; override;
  end;

var
  ConfigAmbiTermForm: TConfigAmbiTermForm;

implementation

{$R *.dfm}

uses App.Config.Ambi.Factory_u, App.Est.Venda.CaixaSessaoDM_u, App.DB.Utils,
  Sis.DB.Factory;

{ TConfigAmbiTermForm }

constructor TConfigAmbiTermForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pAppObj: IAppObj);
var
  rDBConnectionParams: TDBConnectionParams;
begin
  inherited;
  rDBConnectionParams := TerminalIdToDBConnectionParams(0, pAppObj);

  FDBConnection := DBConnectionCreate('config.amb.term.conn', pAppObj.SisConfig,
    rDBConnectionParams, pProcessLog, pOutputNotify);

  FTermDBI := ConfigAmbiTerminalDBIGravaCreate(FDBConnection,
    pUsuarioLog, pAppObj);
  FTerminaisDBGridFrame := TTerminaisDBGridFrame.Create(Self, FTermDBI);
  FTerminaisDBGridFrame.Align := alClient;
  FTerminaisDBGridFrame.ExclAction.Visible := False;
  FTerminaisDBGridFrame.Preparar;
end;

function TConfigAmbiTermForm.GetTitulo: string;
begin
  Result := 'Terminais';
end;

procedure TConfigAmbiTermForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //
end;

end.
