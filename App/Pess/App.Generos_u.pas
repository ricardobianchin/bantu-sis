unit App.Generos_u;

interface

uses App.Generos, System.Classes;


type
  TGeneros = class(TInterfacedObject, IGeneros)
  private
    FValoresSL: TStrings;

    function GetValoresSL: TStrings;
  public
    property ValoresSL: TStrings read GetValoresSL;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils;

{ TGeneros }

constructor TGeneros.Create;
begin
  FValoresSL := TStringList.Create;
  FValoresSL.AddObject('NAO INDICADO', Pointer(32));
  FValoresSL.AddObject('FEMININO', Pointer(33));
  FValoresSL.AddObject('MASCULINO', Pointer(34));
end;

destructor TGeneros.Destroy;
begin
  FreeAndNil(FValoresSL);
  inherited;
end;

function TGeneros.GetValoresSL: TStrings;
begin
  Result := FValoresSL;
end;

end.

