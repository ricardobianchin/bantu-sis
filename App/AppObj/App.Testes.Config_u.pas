unit App.Testes.Config_u;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Xml.XMLDoc, Xml.XMLIntf,
  App.Testes.Config, Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI_u;

type
  TAppTestesConfig = class(TConfigXMLI, IAppTestesConfig)
  private
    FModuConfAutoExec: boolean;
    FModuConfAmbiLojaAutoExec: boolean;

    ModuConfNode
    , ModuConf_AutoExec_Node
    , ModuConf_Ambi_Node
    , ModuConf_AmbiLoja_Node
    , ModuConf_AmbiLoja_AutoExec_Node
      : IXMLNODE;

    function GetModuConfAutoExec: boolean;
    procedure SetModuConfAutoExec(Value: boolean);

    function GetModuConfAmbiLojaAutoExec: boolean;
    procedure SetModuConfAmbiLojaAutoExec(Value: boolean);
  protected
    procedure Inicialize; override;
    function PrepLer: boolean; override;
    function PrepGravar: boolean; override;

  public
    property ModuConfAutoExec: boolean read GetModuConfAutoExec write SetModuConfAutoExec;
    property ModuConfAmbiLojaAutoExec: boolean read GetModuConfAmbiLojaAutoExec write SetModuConfAmbiLojaAutoExec;

    constructor Create(pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

uses System.SysUtils, Sis.Types.Bool_u;

{ TAppTestesConfig }

constructor TAppTestesConfig.Create(pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create('testes', 'app.testes.config', '.xml', '', False, pProcessLog, pOutput);
end;

function TAppTestesConfig.GetModuConfAmbiLojaAutoExec: boolean;
begin
  Result := FModuConfAmbiLojaAutoExec;
end;

function TAppTestesConfig.GetModuConfAutoExec: boolean;
begin
  Result := FModuConfAutoExec;
end;

procedure TAppTestesConfig.Inicialize;
begin
  inherited;
  FModuConfAutoExec := False;
  FModuConfAmbiLojaAutoExec := False;
end;

function TAppTestesConfig.PrepGravar: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  ModuConfNode := RootNode.AddChild('modulo_config');
  begin
    ModuConf_AutoExec_Node := ModuConfNode.AddChild('autoexec');
    begin
      ModuConf_Ambi_Node := ModuConf_AutoExec_Node.AddChild('ambiente');
      ModuConf_AmbiLoja_AutoExec_Node := ModuConf_Ambi_Node.AddChild
        ('autoexec');
    end;
  end;

  ModuConf_AutoExec_Node.Text := BooleanToStr(FModuConfAutoExec);
  ModuConf_AmbiLoja_AutoExec_Node.Text := BooleanToStr(FModuConfAmbiLojaAutoExec);
end;

function TAppTestesConfig.PrepLer: boolean;
var
  s: string;
begin
  Result := inherited PrepLer;
  if not Result then
    exit;

  ModuConfNode := RootNode.ChildNodes['modulo_config'];
  begin
    ModuConf_AutoExec_Node := ModuConfNode.ChildNodes['autoexec'];
    begin
      ModuConf_Ambi_Node := ModuConfNode.ChildNodes['ambiente'];
      ModuConf_AmbiLoja_Node := ModuConf_Ambi_Node.ChildNodes['loja'];
      ModuConf_AmbiLoja_AutoExec_Node := ModuConf_AmbiLoja_Node.ChildNodes
        ['autoexec'];
    end;
  end;

  s := ModuConf_AutoExec_Node.Text;
  FModuConfAutoExec := StrToBoolean(s);

  s := ModuConf_AmbiLoja_AutoExec_Node.Text;
  FModuConfAmbiLojaAutoExec:= StrToBoolean(s);
end;

procedure TAppTestesConfig.SetModuConfAmbiLojaAutoExec(Value: boolean);
begin
  FModuConfAmbiLojaAutoExec := Value;
end;

procedure TAppTestesConfig.SetModuConfAutoExec(Value: boolean);
begin
  FModuConfAutoExec := Value;
end;

end.
