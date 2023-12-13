unit btu.lib.db.exec_u;

interface

uses
  btu.lib.db.types
  , btu.lib.db.dbms
  , sis.ui.io.output
  , sis.ui.io.ProcessLog
  , btu.lib.db.sqloperation_u
  , FireDAC.Stan.Param
  , System.Classes
  , Data.DB
  ;

type
  TDBExec = class(TDBSqlOperation, IDBExec)
  protected
  public
    procedure Execute; virtual; abstract;
  end;

implementation

end.
