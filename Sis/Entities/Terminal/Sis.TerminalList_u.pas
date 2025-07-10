unit Sis.TerminalList_u;

interface

uses System.Classes, Sis.Terminal, Sis.TerminalList, Sis.Entities.Types;

type
  TTerminalList = class(TInterfaceList, ITerminalList)
  private
    function GetTerminal(Index: Integer): ITerminal;
    function GetAsString: string;
  public
    property Terminal[Index: Integer]: ITerminal read GetTerminal; default;
    function TerminalIdToTerminal(pTerminalId: TTerminalId): ITerminal;
    function TerminalIdToIndex(pTerminalId: TTerminalId): integer;
    procedure ExecuteForAll(const Proc: TTerminalProcedure; const pNomeNaRede: string= '');

    property AsString: string read GetAsString;
  end;

implementation

{ TTerminalList }

procedure TTerminalList.ExecuteForAll(const Proc: TTerminalProcedure; const pNomeNaRede: string= '');
var
  oTerminal: ITerminal;
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    oTerminal := Terminal[i];
    if pNomeNaRede <> '' then
      if oTerminal.NomeNaRede <> pNomeNaRede then
        continue;
    Proc(oTerminal);
  end;
end;

function TTerminalList.GetAsString: string;
var
  oTerminal: ITerminal;
  i: integer;
  sLinha: string;
begin
  Result := '';

  for i := 0 to Count - 1 do
  begin
    oTerminal := Terminal[i];
    sLinha := oTerminal.AsText;
    Result := Result + sLinha + #13#10;
  end;
end;

function TTerminalList.GetTerminal(Index: Integer): ITerminal;
begin
  Result := ITerminal(Items[Index]);
end;

function TTerminalList.TerminalIdToIndex(pTerminalId: TTerminalId): integer;
var
  oTerminal: ITerminal;
  i: integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    oTerminal := Terminal[i];
    if oTerminal.TerminalId = pTerminalId then
    begin
      Result := i;
      break;
    end;
  end;
end;

function TTerminalList.TerminalIdToTerminal(
  pTerminalId: TTerminalId): ITerminal;
var
  oTerminal: ITerminal;
  i: integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    oTerminal := Terminal[i];
    if oTerminal.TerminalId = pTerminalId then
    begin
      Result := oTerminal;
      break;
    end;
  end;
end;

end.
