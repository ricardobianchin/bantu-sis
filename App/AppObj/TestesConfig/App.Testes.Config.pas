unit App.Testes.Config;

interface

uses Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI //
  , App.Testes.Config.ModuConf //
  ; //

type
  IAppTestesConfig = interface(IConfigXMLI)
    ['{0B6E6DA1-9718-44DA-8132-E93A9B09C3B4}']
    function GetModuConf: ITesteConfigModuConf;
    property ModuConf: ITesteConfigModuConf read GetModuConf;
  end;

implementation

end.
