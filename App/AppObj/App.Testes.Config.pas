unit App.Testes.Config;

interface

uses Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI;

type
  IAppTestesConfig = interface(IConfigXMLI)
    ['{B64DB4A9-B8D7-4D8D-86B0-16E83253FFFE}']
    function GetModuConfAutoExec: boolean;
    procedure SetModuConfAutoExec(Value: boolean);
    property ModuConfAutoExec: boolean read GetModuConfAutoExec write SetModuConfAutoExec;

    function GetModuConfAmbiLojaAutoExec: boolean;
    procedure SetModuConfAmbiLojaAutoExec(Value: boolean);
    property ModuConfAmbiLojaAutoExec: boolean read GetModuConfAmbiLojaAutoExec write SetModuConfAmbiLojaAutoExec;

//    function Get: boolean;
//    procedure Set(Value: boolean);
//    property : boolean read Get write Set;


  end;
implementation

end.
