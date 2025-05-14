unit App.Est.EstMovDBI;

interface

uses App.Ent.DBI, Sis.Entities.Types, Sis.Types, App.Est.EstMovItem;

type
  IEstMovDBI = interface(IEntDBI)
    ['{D07C3BB6-2982-4E20-BC88-0F28100C4FE3}']
    procedure EstMovCancele(out pCanceladoEm: TDateTime; out pErroDeu: Boolean;
      out pErroMens: string; pLojaId: TLojaId; pEstMovId: Int64;
      pTerminalId: TTerminalId = 0; pModuloSisId: Char = '#');

    procedure EstMovCanceleItem(out pErroDeu: Boolean; out pErroMens: string;
      pLojaId: TLojaId; pEstMovId: Int64; pOrdem: SmallInt;
      pTerminalId: TTerminalId = 0; pModuloSisId: Char = '#');
  end;

implementation

end.
