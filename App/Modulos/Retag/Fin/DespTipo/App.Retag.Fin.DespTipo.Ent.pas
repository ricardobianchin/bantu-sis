unit App.Retag.Fin.DespTipo.Ent;

interface

uses App.Ent.Ed.Id.Descr;

type
  IDespTipoEnt = interface(IEntIdDescr)
    ['{750E5854-B5E3-4654-AB7C-5AFB37CA6EF5}']
    function GetLojaId: smallint;
    property LojaId: smallint read GetLojaId;

    function GetUsuarioId: integer;
    property UsuarioId: integer read GetUsuarioId;

    function GetMachineIdentId: smallint;
    property MachineIdentId: smallint read GetMachineIdentId;
  end;

implementation

end.
