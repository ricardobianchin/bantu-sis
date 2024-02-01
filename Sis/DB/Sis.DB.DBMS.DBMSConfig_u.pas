unit Sis.DB.DBMS.DBMSConfig_u;

interface

uses Sis.UI.IO.Output, Sis.Config.SisConfig, Sis.UI.IO.Output.ProcessLog,
  Sis.DB.DBTypes, Sis.Config_u,  Xml.XMLDoc, Xml.XMLIntf;

type
  TDBMSConfig = class(TConfig, IDBMSConfig)
  private
    FSisConfig: ISisConfig;
    FPausaAntesExec: boolean;

    DebugNode, PausaAntesExecNode: IXMLNODE;

    function GetPausaAntesExec: boolean;
    procedure SetPausaAntesExec(Value: boolean);
  protected
    function Ler: boolean; override;
    procedure Gravar; override;
    procedure Inicialize; override;
    function GetNomeArq: string; override;

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
  FSisConfig := pSisConfig;
  inherited Create(pProcessLog, pOutput);
end;

function TDBMSConfig.GetNomeArq: string;
begin
  Result := 'DBMS.Firebird.Config.xml';
end;

function TDBMSConfig.GetPausaAntesExec: boolean;
begin
  Result := FPausaAntesExec;
end;

procedure TDBMSConfig.Gravar;
begin
  inherited Gravar;
  RootNode := XMLDocument1.AddChild('dbms');
  DebugNode := RootNode.AddChild('debug');
  PausaAntesExecNode := DebugNode.AddChild('pausa_antes_exec');

  PausaAntesExecNode.Text := BooleanToStr(FPausaAntesExec);
  XMLDocumentSalvar;
end;

procedure TDBMSConfig.Inicialize;
begin
  inherited;
  FPausaAntesExec := false;
end;

function TDBMSConfig.Ler: boolean;
var
  s: string;
begin
  Result := inherited Ler;
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
