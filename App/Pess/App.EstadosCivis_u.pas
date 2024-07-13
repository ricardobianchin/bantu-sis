unit App.EstadosCivis_u;

interface

uses App.EstadosCivis, System.Classes;

type
  TEstadosCivis = class(TInterfacedObject, IEstadosCivis)
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

{ TEstadosCivis }

constructor TEstadosCivis.Create;
begin
  FValoresSL := TStringList.Create;

  FValoresSL.AddObject('NAO INDICADO', Pointer(32));
  FValoresSL.AddObject('SOLTEIRO', Pointer(33));
  FValoresSL.AddObject('CASADO', Pointer(34));
  FValoresSL.AddObject('SEPARADO', Pointer(35));
  FValoresSL.AddObject('DIVORCIADO', Pointer(36));
  FValoresSL.AddObject('VIUVO', Pointer(37));

end;

destructor TEstadosCivis.Destroy;
begin
  FreeAndNil(FValoresSL);
  inherited;
end;

function TEstadosCivis.GetValoresSL: TStrings;
begin
  Result := FValoresSL;
end;

end.
