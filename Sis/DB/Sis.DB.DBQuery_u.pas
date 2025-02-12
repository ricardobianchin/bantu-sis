unit Sis.DB.DBQuery_u;

interface

uses
  FireDAC.Stan.Param
  , System.Classes
  , Data.DB, Sis.DB.DBSQLOperation_u, Sis.DB.DBTypes
  ;

type
  TDBQuery = class(TDBSqlOperation, IDBQuery)
  protected
    function GetIsEmpty: boolean; virtual; abstract;
    function GetDataSet: TDataSet; virtual; abstract;
    function GetActive: boolean; virtual; abstract;
    procedure SetActive(Value: boolean); virtual; abstract;
    function GetFields: TFields; virtual; abstract;
  public
    property Fields: TFields read GetFields;
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
