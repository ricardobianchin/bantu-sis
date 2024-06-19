unit App.Testes.Config_u;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Xml.XMLDoc, Xml.XMLIntf,
  App.Testes.Config, Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI_u, App.Testes.Config.ModuConf;

type
  TAppTestesConfig = class(TConfigXMLI, IAppTestesConfig)
  private
    FModuConf: ITesteConfigModuConf;

    ModuConfNode
    , ModuConf_Ambi_Node
    , ModuConf_AmbiLoja_Node
    , ModuConf_AmbiLoja_AutoExec_Node
      : IXMLNODE;

    function GetModuConf: ITesteConfigModuConf;
  protected
    procedure Inicialize; override;
    function PrepLer: boolean; override;
    function PrepGravar: boolean; override;

  public
    property ModuConf: ITesteConfigModuConf read GetModuConf;

    constructor Create(pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

uses System.SysUtils, App.Testes.Config.Factory, Sis.Types.Bool_u;

{ TAppTestesConfig }

constructor TAppTestesConfig.Create(pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FModuConf := ModuConfCreate;
  inherited Create('testes', 'app.testes.config', '.xml', '', False, pProcessLog, pOutput);
end;

function TAppTestesConfig.GetModuConf: ITesteConfigModuConf;
begin
  Result := FModuConf;
end;

procedure TAppTestesConfig.Inicialize;
begin
  inherited;
  FModuConf.Ambi.Loja.AutoExec := false;
end;

function TAppTestesConfig.PrepGravar: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  ModuConfNode := RootNode.AddChild('modulo_config');
  begin
    begin
      ModuConf_Ambi_Node := ModuConf_Ambi_Node.AddChild('ambiente');
      begin
        ModuConf_AmbiLoja_Node := ModuConf_Ambi_Node.AddChild('loja');
        begin
          ModuConf_AmbiLoja_AutoExec_Node := ModuConf_Ambi_Node.AddChild
            ('autoexec');
        end;
      end;
    end;
  end;

  ModuConf_AmbiLoja_AutoExec_Node.Text := BooleanToStr(FModuConf.Ambi.Loja.AutoExec);
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
    begin
      ModuConf_Ambi_Node := ModuConfNode.ChildNodes['ambiente'];
      begin
        ModuConf_AmbiLoja_Node := ModuConf_Ambi_Node.ChildNodes['loja'];
        begin
          ModuConf_AmbiLoja_AutoExec_Node := ModuConf_AmbiLoja_Node.ChildNodes
            ['autoexec'];
        end;
      end;
    end;
  end;

  s := ModuConf_AmbiLoja_AutoExec_Node.Text;
  FModuConf.Ambi.Loja.AutoExec := StrToBoolean(s);
end;

end.
