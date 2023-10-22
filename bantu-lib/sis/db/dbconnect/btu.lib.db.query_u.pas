unit btu.lib.db.query_u;

interface

uses
  btu.lib.db.types
  , btu.lib.db.dbms
  , sis.ui.io.output
  , sis.ui.io.log
  , btu.lib.db.sqloperation_u
  , FireDAC.Stan.Param
  , System.Classes
  , Data.DB
  ;

type
  TDBQuery = class(TDBSqlOperation, IDBQuery)
  protected
    function GetIsEmpty: boolean; virtual; abstract;
    function GetDataSet: TDataSet; virtual; abstract;
    function GetActive: boolean; virtual; abstract;
    procedure SetActive(Value: boolean); virtual; abstract;
  public
    function Abrir: boolean; virtual; abstract;
    procedure Fechar; virtual; abstract;
    function Open: boolean;
    procedure Close;

    property Active: boolean read GetActive write SetActive;

    property IsEmpty: boolean read GetIsEmpty;
    property DataSet: TDataSet read GetDataSet;
  end;

implementation

{ TDBQuery }

procedure TDBQuery.Close;
begin
  Fechar;
end;

function TDBQuery.Open: boolean;
begin
  Result := Abrir;
end;

end.
