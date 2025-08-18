unit Sis.DB.Updater;

interface

uses
  sis.sis.Executavel, Sis.DB.DBTypes
  ;

type
  IDBUpdater = interface(IExecutavel)
    ['{A25526B2-C160-4DD1-B784-7D7B4A72EE52}']

    function GetDBExisteRetorno: TDBExisteRetorno;
    procedure SetDBExisteRetorno(Values: TDBExisteRetorno);
    property DBExisteRetorno: TDBExisteRetorno read GetDBExisteRetorno write SetDBExisteRetorno;
  end;

implementation

end.
