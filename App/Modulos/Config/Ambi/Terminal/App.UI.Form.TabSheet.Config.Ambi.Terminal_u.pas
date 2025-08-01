unit App.UI.Form.TabSheet.Config.Ambi.Terminal_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  App.UI.Frame.DBGrid.Config.Ambi.Terminal_u, App.AppObj, Sis.DB.DBTypes,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario,
  App.Config.Ambi.Terminal.DBI, Sis.Terminal.DBI, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TConfigAmbiTermForm = class(TTabSheetAppBasForm)
    ServFDConnection: TFDConnection;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FDBConnection: IDBConnection;
    FAmbiTermDBI: IConfigAmbiTerminalDBI;
    FTerminaisDBGridFrame: TTerminaisDBGridFrame;
    FTerminalDBI: ITerminalDBI;
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
  Sis.DB.Factory, Sis.Terminal.Factory_u;

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

  FTerminalDBI := TerminalDBICreate(FDBConnection);
  FAmbiTermDBI := ConfigAmbiTerminalDBIGravaCreate(FDBConnection, pUsuarioLog,
    pAppObj, FTerminalDBI);
  FTerminaisDBGridFrame := TTerminaisDBGridFrame.Create(Self, FAmbiTermDBI, ServFDConnection, True);
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
