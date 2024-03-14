unit App.SisConfig.DBI;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, Sis.Config.SisConfig;

type
  ISisConfigDBI = interface(IInterface)
    ['{A83BEA7E-7D4B-4DA6-93D6-F7AAB10C7F5D}']
    procedure LerMachineIdent;
  end;

implementation

end.
