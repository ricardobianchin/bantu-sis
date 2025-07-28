unit Sis.DB.DBMS.DBMSConfig_u;

interface

uses Sis.UI.IO.Output, Sis.Config.SisConfig, Sis.UI.IO.Output.ProcessLog,
  Sis.DB.DBTypes, Xml.XMLDoc, Xml.XMLIntf, Sis.Config.ConfigXMLI_u;

type
  TDBMSConfig = class(TConfigXMLI, IDBMSConfig)
  private
    FSisConfig: ISisConfig;
    FPausaAntesExec: boolean;

    DebugNode, PausaAntesExecNode: IXMLNODE;

    function GetPausaAntesExec: boolean;
    procedure SetPausaAntesExec(Value: boolean);
  protected
    function PrepLer(var sLog: string): boolean; override;
    function  PrepGravar(var sLog: string): boolean;  override;
    procedure Inicialize; override;

  public
    property PausaAntesExec: boolean read GetPausaAntesExec
      write SetPausaAntesExec;
    constructor Create(pSisConfig: ISisConfig; pProcessLog: IProcessLog;
      pOutput: IOutput);
  end;

implementation

uses System.SysUtils, Sis.Types.Bool_u, Sis.UI.IO.Files;

{ TDBMSConfig }

constructor TDBMSConfig.Create(pSisConfig: ISisConfig; pProcessLog: IProcessLog;
  pOutput: IOutput);
begin
  inherited Create('dbms', 'DBMS.Firebird.Config', '.xml', '', False,
    pProcessLog, pOutput);
  FSisConfig := pSisConfig;
end;

function TDBMSConfig.GetPausaAntesExec: boolean;
begin
  Result := FPausaAntesExec;
end;

procedure TDBMSConfig.Inicialize;
begin
  inherited;
  FPausaAntesExec := false;
end;

function TDBMSConfig.PrepGravar(var sLog: string): boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  DebugNode := RootNode.AddChild('debug');
  PausaAntesExecNode := DebugNode.AddChild('pausa_antes_exec');

  PausaAntesExecNode.Text := BooleanToStr(FPausaAntesExec);
end;

function TDBMSConfig.PrepLer(var sLog: string): boolean;
var
  s: string;
begin
  Result := inherited PrepLer(sLog);
  if not Result then
    exit;

  DebugNode := RootNode.ChildNodes['debug'];
  PausaAntesExecNode := DebugNode.ChildNodes['pausa_antes_exec'];

  s := PausaAntesExecNode.Text;
  FPausaAntesExec := StrToBoolean(s);
end;

procedure TDBMSConfig.SetPausaAntesExec(Value: boolean);
begin
  FPausaAntesExec := Value;
end;

end.
