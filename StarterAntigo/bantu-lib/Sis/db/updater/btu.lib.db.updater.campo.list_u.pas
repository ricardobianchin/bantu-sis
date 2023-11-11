unit btu.lib.db.updater.campo.list_u;

interface

uses btu.lib.db.updater.campo.list, System.Classes, btu.lib.db.updater.campo;

type
  TCampoList = class(TInterfaceList, ICampoList)
  private
    function GetPKFieldNames: string;
    function GetCampo(Index: integer): ICampo;
    function GetAsCreateTableFields: string;
  public
    property PKFieldNames: string read GetPKFieldNames;
    property Campo[Index: integer]: ICampo read GetCampo; default;
    property AsCreateTableFields: string read GetAsCreateTableFields;
  end;

implementation

{ TCampoList }

function TCampoList.GetAsCreateTableFields: string;
var
  oCampo: ICampo;
  I: Integer;
begin
  Result := '';
  for I := 0 to Count - 1 do
  begin
    if Result <> '' then
      Result := Result + '  , '
    else
      Result := Result + '  ';

    oCampo := Campo[I];
    Result := Result + oCampo.AsCreateTableField + #13#10;
  end;
end;

function TCampoList.GetCampo(Index: integer): ICampo;
begin
  result := ICampo(Items[Index]);
end;

function TCampoList.GetPKFieldNames: string;
var
  oCampo: ICampo;
  I: Integer;
begin
  Result := '';
  for I := 0 to Count - 1 do
  begin
    oCampo := Campo[I];
    if oCampo.PrimaryKey then
    begin
      if Result <> '' then
        Result := Result + ', ';
      Result := Result + oCampo.Nome;
    end;
  end;
end;

end.
