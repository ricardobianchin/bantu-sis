unit App.Testes.Config_u;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Xml.XMLDoc, Xml.XMLIntf,
  App.Testes.Config, Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI_u //

    , App.Testes.Config.ModuConf //

    , App.Testes.Config.ModuRetag //

    , App.Testes.Config.App //
    ;

type
  TAppTestesConfig = class(TConfigXMLI, IAppTestesConfig)
  private
    FModuConf: ITesteConfigModuConf;

    FModuRetag: ITesteConfigModuRetag;

    FApp: ITesteConfigApp;

    ModuConfNode //
    , ModuConf_Ambi_Node //
    , ModuConf_Ambi_Loja_Node //
    , ModuConf_Ambi_Loja_AutoExec_Node //
      : IXMLNODE; //

    ModuRetagNode //
    , ModuRetag_Acesso_Node //
    , ModuRetag_Acesso_PerfilDeUso_Node //
    , ModuRetag_Acesso_PerfilDeUso_AutoExec_Node //
      : IXMLNODE; //

    App_Node //
    , App_ExecsAtu_Node //
      : IXMLNODE; //

    function GetModuConf: ITesteConfigModuConf;

    function GetModuRetag: ITesteConfigModuRetag;

    function GetApp: ITesteConfigApp;

  protected
    procedure Inicialize; override;
    function PrepLer: boolean; override;
    function PrepGravar: boolean; override;

  public
    property ModuConf: ITesteConfigModuConf read GetModuConf;

    property ModuRetag: ITesteConfigModuRetag read GetModuRetag;

    property App: ITesteConfigApp read GetApp;

    constructor Create(pProcessLog: IProcessLog = nil; pOutput: IOutput = nil);
  end;

implementation

uses System.SysUtils, App.Testes.Config.Factory, Sis.Types.Bool_u;

{ TAppTestesConfig }

constructor TAppTestesConfig.Create(pProcessLog: IProcessLog; pOutput: IOutput);
begin
  FModuConf := ModuConfCreate;
  FModuRetag := ModuRetagCreate;
  FApp := AppCreate;
  inherited Create('testes', 'app.testes.config', '.xml', '', False,
    pProcessLog, pOutput);
end;

function TAppTestesConfig.GetApp: ITesteConfigApp;
begin
  Result := FApp;
end;

function TAppTestesConfig.GetModuConf: ITesteConfigModuConf;
begin
  Result := FModuConf;
end;

function TAppTestesConfig.GetModuRetag: ITesteConfigModuRetag;
begin
  Result := FModuRetag;
end;

procedure TAppTestesConfig.Inicialize;
begin
  inherited;
  FModuConf.Ambi.Loja.AutoExec := False;
  FModuRetag.Acesso.PerfilDeUso.AutoExec := False;
  FApp.ExecsAtu := True;
end;

function TAppTestesConfig.PrepGravar: boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  ModuConfNode := RootNode.AddChild('modulo_config');
  begin
    begin
      ModuConf_Ambi_Node := ModuConfNode.AddChild('ambiente');
      begin
        ModuConf_Ambi_Loja_Node := ModuConf_Ambi_Node.AddChild('loja');
        begin
          ModuConf_Ambi_Loja_AutoExec_Node := ModuConf_Ambi_Loja_Node.AddChild
            ('autoexec');
        end;
      end;
    end;
  end;

  ModuRetagNode := RootNode.AddChild('modulo_retag');
  begin
    begin
      ModuRetag_Acesso_Node := ModuRetagNode.AddChild('acesso');
      begin
        ModuRetag_Acesso_PerfilDeUso_Node := ModuRetag_Acesso_Node.AddChild
          ('perfil_de_uso');
        begin

          ModuRetag_Acesso_PerfilDeUso_AutoExec_Node :=
            ModuRetag_Acesso_PerfilDeUso_Node.AddChild('autoexec');
        end;
      end;
    end;
  end;

  App_Node := RootNode.AddChild('app');
  begin
    App_ExecsAtu_Node := App_Node.AddChild('versao_atualiza');
    begin
    end;
  end;

  ModuConf_Ambi_Loja_AutoExec_Node.Text :=
    BooleanToStr(FModuConf.Ambi.Loja.AutoExec);
  ModuRetag_Acesso_PerfilDeUso_AutoExec_Node.Text :=
    BooleanToStr(FModuRetag.Acesso.PerfilDeUso.AutoExec);
  App_ExecsAtu_Node.Text := BooleanToStr(FApp.ExecsAtu);
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
        ModuConf_Ambi_Loja_Node := ModuConf_Ambi_Node.ChildNodes['loja'];
        begin
          ModuConf_Ambi_Loja_AutoExec_Node := ModuConf_Ambi_Loja_Node.ChildNodes
            ['autoexec'];
        end;
      end;
    end;
  end;

  ModuRetagNode := RootNode.ChildNodes['modulo_retag'];
  begin
    begin
      ModuRetag_Acesso_Node := ModuRetagNode.ChildNodes['acesso'];
      begin
        ModuRetag_Acesso_PerfilDeUso_Node := ModuRetag_Acesso_Node.ChildNodes
          ['perfil_de_uso'];
        begin
          ModuRetag_Acesso_PerfilDeUso_AutoExec_Node :=
            ModuRetag_Acesso_PerfilDeUso_Node.ChildNodes['autoexec'];
        end;
      end;
    end;
  end;

  App_Node := RootNode.ChildNodes['app'];
  begin
    begin
      App_ExecsAtu_Node := App_Node.ChildNodes['versao_atualiza'];
    end;
  end;

  s := ModuConf_Ambi_Loja_AutoExec_Node.Text;
  FModuConf.Ambi.Loja.AutoExec := StrToBoolean(s);

  s := ModuRetag_Acesso_PerfilDeUso_AutoExec_Node.Text;
  FModuRetag.Acesso.PerfilDeUso.AutoExec := StrToBoolean(s);

  s := App_ExecsAtu_Node.Text;
  FApp.ExecsAtu := StrToBoolean(s);
end;

end.
