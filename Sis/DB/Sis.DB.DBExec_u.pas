unit Sis.DB.DBExec_u;

interface

uses
  FireDAC.Stan.Param, System.Classes, Data.DB, Sis.DB.DBSQLOperation_u,
  Sis.DB.DBTypes;

type
  TDBExec = class(TDBSqlOperation, IDBExec)
  protected
  public
    procedure Execute; virtual; abstract;
  end;

implementation

end.
