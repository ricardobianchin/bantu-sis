unit Sis.DB.FDDataSetManager;

interface

uses System.Classes;

type
  IFDDataSetManager = interface(IInterface)
    ['{CC4953CD-EE8B-4DA4-A128-E9F3EE238C23}']
    procedure DefinaCampos(pDefsSL: TStringList);
  end;

implementation

end.
