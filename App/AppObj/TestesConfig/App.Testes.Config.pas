unit App.Testes.Config;

interface

{
  o nome do objeto tem a palavra config no nome
  nao confundir com o nome do mudulo config que tem a mesma palavra

  AppTestesConfig este objeto, configuracoes de testes da camada APP

  ModuConf é um dos modulos do sistema, junto com:
  ModuRetag
  ModuPDV

  ModuConf: ITesteConfigModuConf
  ModuRetag: ITesteConfigModuRetag
  ModuPDV: ITesteConfigModuPDV
}

uses Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI //

  , App.Testes.Config.ModuConf //

  , App.Testes.Config.ModuRetag //

  , App.Testes.Config.App //

  ; //

type
  IAppTestesConfig = interface(IConfigXMLI)
    ['{0B6E6DA1-9718-44DA-8132-E93A9B09C3B4}']
    function GetModuConf: ITesteConfigModuConf;
    property ModuConf: ITesteConfigModuConf read GetModuConf;

    function GetModuRetag: ITesteConfigModuRetag;
    property ModuRetag: ITesteConfigModuRetag read GetModuRetag;

    function GetApp: ITesteConfigApp;
    property App: ITesteConfigApp read GetApp;
  end;

implementation

end.
