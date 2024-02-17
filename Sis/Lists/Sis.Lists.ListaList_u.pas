unit Sis.Lists.ListaList_u;

interface

uses Sis.Lists.Lista, System.Classes;

type
  TListaList = class(TInterfacedObject, ILista)
  private
    FList: TList;

    function GetCount:integer;
    function GetList: TList;
  protected
    property List: TList read GetList;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    property Count:integer read GetCount;
  end;

implementation

{ TListaList }

procedure TListaList.Clear;
begin
  FList.Clear;
end;

constructor TListaList.Create;
begin
  FList:=TList.Create;
end;

destructor TListaList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TListaList.GetCount: integer;
begin
  Result := FList.Count;
end;

function TListaList.GetList: TList;
begin
  Result := FList;
end;

end.
