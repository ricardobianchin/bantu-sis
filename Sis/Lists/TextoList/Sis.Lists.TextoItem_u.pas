unit Sis.Lists.TextoItem_u;

interface

uses Sis.Lists.TextoItem;

type
  TTextoItem = class( TInterfacedObject, ITextoItem)
  private
    FTitulo: string;
    FTexto: string;

    function GetTitulo: string;
    procedure SetTitulo(Value: string);

    function GetTexto: string;
    procedure SetTexto(Value: string);
  public
    property Titulo: string read GetTitulo write SetTitulo;
    property Texto: string read GetTexto write SetTexto;

    constructor Create(pTitulo: string = ''; pTexto: string = '');
  end;

implementation

{ TTextoItem }

constructor TTextoItem.Create(pTitulo, pTexto: string);
begin
  FTitulo := pTitulo;
  FTexto := pTexto;
end;

function TTextoItem.GetTexto: string;
begin
  Result := FTexto;
end;

function TTextoItem.GetTitulo: string;
begin
  Result := FTitulo;
end;

procedure TTextoItem.SetTexto(Value: string);
begin
  FTexto := Value;
end;

procedure TTextoItem.SetTitulo(Value: string);
begin
  FTitulo := Value;
end;

end.
