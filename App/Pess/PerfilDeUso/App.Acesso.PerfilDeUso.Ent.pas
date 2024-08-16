unit App.Acesso.PerfilDeUso.Ent;

interface

uses App.Ent.Ed.Id.Descr;

type
  IPerfilDeUsoEnt = interface(IEntIdDescr)
    ['{90FCC616-CC4B-49AC-B57D-F31296B03DBF}']
    function GetDeSistema: boolean;
    procedure SetDeSistema(Value: boolean);
    property DeSistema: boolean read GetDeSistema write SetDeSistema;

    function GetUsuariosApelidos: string;
    procedure SetUsuariosApelidos(Value: string);
    property UsuariosApelidos: string read GetUsuariosApelidos write SetUsuariosApelidos;
  end;

implementation

end.
