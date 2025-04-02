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

      , ModuConf_Import_Node //
      , ModuConf_Import_AutoExec_Node //
      , ModuConf_Import_Origem_Node //
      : IXMLNODE; //

    ModuRetagNode //
      , ModuRetag_Acesso_Node //
      , ModuRetag_Acesso_PerfilDeUso_Node //
      , ModuRetag_Acesso_PerfilDeUso_AutoExec_Node //

      , ModuRetag_Acesso_Funcionario_Node //
      , ModuRetag_Acesso_Funcionario_AutoExec_Node //

      , ModuRetag_Est_Node //
      , ModuRetag_Est_Cliente_Node //
      , ModuRetag_Est_Cliente_AutoExec_Node //

      , ModuRetag_Est_Produtos_Node //
      , ModuRetag_Est_Produtos_AutoExec_Node //

      , ModuRetag_Fin_Node //
      , ModuRetag_Fin_PagamentoForma_Node //
      , ModuRetag_Fin_PagamentoForma_AutoExec_Node //

      , ModuRetag_Ajuda_Node //
      , ModuRetag_Ajuda_BemVindo_Node //
      , ModuRetag_Ajuda_BemVindo_Terminais_Node //
      , ModuRetag_Ajuda_BemVindo_Terminais_AutoExec_Node //
      , ModuRetag_Ajuda_BemVindo_Terminais_SelectTerminalIds_Node //

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

      ModuConf_Import_Node := ModuConfNode.AddChild('import');
      begin
        ModuConf_Import_AutoExec_Node := ModuConf_Import_Node.AddChild
          ('autoexec');
        ModuConf_Import_Origem_Node := ModuConf_Import_Node.AddChild('origem');
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

        ModuRetag_Acesso_Funcionario_Node := ModuRetag_Acesso_Node.AddChild
          ('funcionario');
        begin
          ModuRetag_Acesso_Funcionario_AutoExec_Node :=
            ModuRetag_Acesso_Funcionario_Node.AddChild('autoexec');
        end;
      end;
    end;

    begin
      ModuRetag_Est_Node := ModuRetagNode.AddChild('est');
      begin
        ModuRetag_Est_Cliente_Node := ModuRetag_Est_Node.AddChild('cliente');
        begin

          ModuRetag_Est_Cliente_AutoExec_Node :=
            ModuRetag_Est_Cliente_Node.AddChild('autoexec');
        end;

        ModuRetag_Est_Produtos_Node := ModuRetag_Est_Node.AddChild('produtos');
        begin

          ModuRetag_Est_Produtos_AutoExec_Node :=
            ModuRetag_Est_Produtos_Node.AddChild('autoexec');
        end;
      end;

      ModuRetag_Fin_Node := ModuRetagNode.AddChild('fin');
      begin
        ModuRetag_Fin_PagamentoForma_Node := ModuRetag_Fin_Node.AddChild
          ('pagamento_forma');
        begin

          ModuRetag_Fin_PagamentoForma_AutoExec_Node :=
            ModuRetag_Fin_PagamentoForma_Node.AddChild('autoexec');
        end;
      end;

      ModuRetag_Ajuda_Node := ModuRetagNode.AddChild('ajuda');
      begin
        ModuRetag_Ajuda_BemVindo_Node := ModuRetag_Ajuda_Node.AddChild
          ('bemvindo');
        begin
          ModuRetag_Ajuda_BemVindo_Terminais_Node :=
            ModuRetag_Ajuda_BemVindo_Node.AddChild('terminais');
          begin
            ModuRetag_Ajuda_BemVindo_Terminais_AutoExec_Node :=
              ModuRetag_Ajuda_BemVindo_Terminais_Node.AddChild('autoexec');
            ModuRetag_Ajuda_BemVindo_Terminais_SelectTerminalIds_Node :=
              ModuRetag_Ajuda_BemVindo_Terminais_Node.AddChild
              ('select_terminal_ids');
          end;
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

  // conf
  ModuConf_Ambi_Loja_AutoExec_Node.Text :=
    BooleanToStr(FModuConf.Ambi.Loja.AutoExec);

  ModuConf_Import_AutoExec_Node.Text := BooleanToStr(FModuConf.Import.AutoExec);
  ModuConf_Import_Origem_Node.Text := AnsiUpperCase(FModuConf.Import.Origem);

  // retag

  // retag acesso

  // retag acesso perfil de uso
  ModuRetag_Acesso_PerfilDeUso_AutoExec_Node.Text :=
    BooleanToStr(FModuRetag.Acesso.PerfilDeUso.AutoExec);

  // retag acess funcionario
  ModuRetag_Acesso_Funcionario_AutoExec_Node.Text :=
    BooleanToStr(FModuRetag.Acesso.Funcionario.AutoExec);


  // retag est

  // retag est Cliente
  ModuRetag_Est_Cliente_AutoExec_Node.Text :=
    BooleanToStr(FModuRetag.Est.Cliente.AutoExec);

  // retag est Produtos
  ModuRetag_Est_Produtos_AutoExec_Node.Text :=
    BooleanToStr(FModuRetag.Est.Produtos.AutoExec);

  // retag fin PagamentoForma
  ModuRetag_Fin_PagamentoForma_AutoExec_Node.Text :=
    BooleanToStr(FModuRetag.Fin.PagamentoForma.AutoExec);

  // retag ajuda

  // retag ajuda bemvindo

  // retab ajuda bemvindo terminais
  ModuRetag_Ajuda_BemVindo_Terminais_AutoExec_Node.Text :=
    BooleanToStr(FModuRetag.Ajuda.BemVindo.Terminais.AutoExec);
  ModuRetag_Ajuda_BemVindo_Terminais_SelectTerminalIds_Node.Text :=
    FModuRetag.Ajuda.BemVindo.Terminais.SelectTerminalIds;

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

    begin
      ModuConf_Import_Node := ModuConfNode.ChildNodes['import'];
      begin
        ModuConf_Import_AutoExec_Node := ModuConf_Import_Node.ChildNodes
          ['autoexec'];
        ModuConf_Import_Origem_Node := ModuConf_Import_Node.ChildNodes
          ['origem'];
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

        ModuRetag_Acesso_Funcionario_Node := ModuRetag_Acesso_Node.ChildNodes
          ['funcionario'];
        begin
          ModuRetag_Acesso_Funcionario_AutoExec_Node :=
            ModuRetag_Acesso_Funcionario_Node.ChildNodes['autoexec'];
        end;
      end;
    end;

    begin
      ModuRetag_Est_Node := ModuRetagNode.ChildNodes['est'];
      begin
        ModuRetag_Est_Cliente_Node := ModuRetag_Est_Node.ChildNodes['cliente'];
        begin
          ModuRetag_Est_Cliente_AutoExec_Node :=
            ModuRetag_Est_Cliente_Node.ChildNodes['autoexec'];
        end;

        ModuRetag_Est_Produtos_Node := ModuRetag_Est_Node.ChildNodes['produtos'];
        begin
          ModuRetag_Est_Produtos_AutoExec_Node :=
            ModuRetag_Est_Produtos_Node.ChildNodes['autoexec'];
        end;
      end;
    end;

    begin
      ModuRetag_Fin_Node := ModuRetagNode.ChildNodes['fin'];
      begin
        ModuRetag_Fin_PagamentoForma_Node := ModuRetag_Fin_Node.ChildNodes
          ['pagamento_forma'];
        begin
          ModuRetag_Fin_PagamentoForma_AutoExec_Node :=
            ModuRetag_Fin_PagamentoForma_Node.ChildNodes['autoexec'];
        end;
      end;
    end;

    begin
      ModuRetag_Ajuda_Node := ModuRetagNode.ChildNodes['ajuda'];
      begin
        ModuRetag_Ajuda_BemVindo_Node := ModuRetag_Ajuda_Node.ChildNodes
          ['bemvindo'];
        begin
          ModuRetag_Ajuda_BemVindo_Terminais_Node :=
            ModuRetag_Ajuda_BemVindo_Node.ChildNodes['terminais'];
          begin
            ModuRetag_Ajuda_BemVindo_Terminais_AutoExec_Node :=
              ModuRetag_Ajuda_BemVindo_Terminais_Node.ChildNodes['autoexec'];
            ModuRetag_Ajuda_BemVindo_Terminais_SelectTerminalIds_Node :=
              ModuRetag_Ajuda_BemVindo_Terminais_Node.ChildNodes
              ['select_terminal_ids'];
          end;
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

  // conf
  // conf ambi loja
  s := ModuConf_Ambi_Loja_AutoExec_Node.Text;
  FModuConf.Ambi.Loja.AutoExec := StrToBoolean(s);

  // conf import
  s := ModuConf_Import_AutoExec_Node.Text;
  FModuConf.Import.AutoExec := StrToBoolean(s);

  s := AnsiUpperCase(ModuConf_Import_Origem_Node.Text);
  FModuConf.Import.Origem := s;

  // retag

  // retag acesso perfil de uso
  s := ModuRetag_Acesso_PerfilDeUso_AutoExec_Node.Text;
  FModuRetag.Acesso.PerfilDeUso.AutoExec := StrToBoolean(s);

  // retag acesso funcionario
  s := ModuRetag_Acesso_Funcionario_AutoExec_Node.Text;
  FModuRetag.Acesso.Funcionario.AutoExec := StrToBoolean(s);

  // retag est cliente
  s := ModuRetag_Est_Cliente_AutoExec_Node.Text;
  FModuRetag.Est.Cliente.AutoExec := StrToBoolean(s);

  // retag est produtos
  s := ModuRetag_Est_Produtos_AutoExec_Node.Text;
  FModuRetag.Est.Produtos.AutoExec := StrToBoolean(s);

  // retag fin pagamento forma
  s := ModuRetag_Fin_PagamentoForma_AutoExec_Node.Text;
  FModuRetag.Fin.PagamentoForma.AutoExec := StrToBoolean(s);

  // retag ajuda bemvindo terminais

  s := ModuRetag_Ajuda_BemVindo_Terminais_AutoExec_Node.Text;
  FModuRetag.Ajuda.BemVindo.Terminais.AutoExec := StrToBoolean(s);

  s := ModuRetag_Ajuda_BemVindo_Terminais_SelectTerminalIds_Node.Text;
  FModuRetag.Ajuda.BemVindo.Terminais.SelectTerminalIds := s;

  // atu
  s := App_ExecsAtu_Node.Text;
  FApp.ExecsAtu := StrToBoolean(s);
end;

end.
