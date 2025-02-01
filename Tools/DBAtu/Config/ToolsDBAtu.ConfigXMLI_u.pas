unit ToolsDBAtu.ConfigXMLI_u;

interface

uses
  Sis.Config.ConfigXMLI_u, ToolsDBAtu.Config, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, Xml.XMLDoc, Xml.XMLIntf;

type
  TToolsDBAtuConfigXMLI = class(TConfigXMLI)
  private
    FToolsDBAtuConfig: IToolsDBAtuConfig;
    FArqTypeBalancaPasNode: IXMLNODE;
  protected
    procedure Inicialize; override;
    function PrepLer: boolean; override;
    function  PrepGravar: boolean;  override;
  public
    constructor Create(pToolsDBAtuConfig: IToolsDBAtuConfig;
      pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

{ TToolsDBAtuConfigXMLI }

uses Sis.Types.Variants, System.SysUtils;

constructor TToolsDBAtuConfigXMLI.Create(pToolsDBAtuConfig: IToolsDBAtuConfig; pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create('tools_dbatu_config', 'Tools.DBAtu.Config', '.xml', '', False,
    pProcessLog, pOutput);

  FToolsDBAtuConfig := pToolsDBAtuConfig;
end;

procedure TToolsDBAtuConfigXMLI.Inicialize;
begin
  inherited;
  FToolsDBAtuConfig.ArqTypeBalancaPas := '';
end;

function TToolsDBAtuConfigXMLI.PrepGravar: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  FArqTypeBalancaPasNode := RootNode.AddChild('arq_type_balanca_pas');
  FArqTypeBalancaPasNode.Text := FToolsDBAtuConfig.ArqTypeBalancaPas;
end;

function TToolsDBAtuConfigXMLI.PrepLer: boolean;
var
  s: string;
begin
  Result := inherited PrepLer;
  if not Result then
    exit;

  FArqTypeBalancaPasNode := RootNode.ChildNodes['arq_type_balanca_pas'];
  FToolsDBAtuConfig.ArqTypeBalancaPas := Trim(FArqTypeBalancaPasNode.Text);
end;

end.
