unit App.Est.EstMovDBI;

interface

uses App.Ent.DBI, Sis.Entities.Types, Sis.Types;

type
  IEstMovDBI = interface(IEntDBI)
    ['{D07C3BB6-2982-4E20-BC88-0F28100C4FE3}']
    procedure EstMovCancele(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pEstMovId: Int64);
    procedure EstMovCanceleItem(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pEstMovId: Int64; pOrdem: SmallInt);
  end;

implementation

end.
