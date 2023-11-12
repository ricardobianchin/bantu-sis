unit btu.lib.db.dbms.config;

interface

type
  IDBMSConfig = interface(IInterface)
    ['{5A1A706A-6F4C-43B8-9F12-D815CC4B23D0}']
    function GetPausaAntesExec: boolean;
    procedure SetPausaAntesExec(Value: boolean);
    property PausaAntesExec: boolean read GetPausaAntesExec write SetPausaAntesExec;
  end;

implementation

end.
