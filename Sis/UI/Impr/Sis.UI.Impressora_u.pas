unit Sis.UI.Impressora_u;

interface

uses Sis.UI.Impressora;

type
  TImpressora = class(TInterfacedObject, IImpressora)
  private
    FNome: string;
    FAberta: Boolean;

    function GetNome: string;

    function GetAberta: Boolean;
    procedure SetAberta(Value: Boolean);

  protected
    function Abrir(pDocTitulo: string): Boolean; virtual;
    procedure Fechar; virtual;

  public
    property Nome: string read GetNome;
    property Aberta: Boolean read GetAberta write SetAberta;
    constructor Create(pNome: string);
  end;

implementation

{ TImpressora }

function TImpressora.Abrir(pDocTitulo: string): Boolean;
begin
  Result := True;
  FAberta := Result;
end;

constructor TImpressora.Create(pNome: string);
begin
  FNome := pNome;
end;

procedure TImpressora.Fechar;
begin
  FAberta := False;
end;

function TImpressora.GetAberta: Boolean;
begin
  Result := FAberta;
end;

function TImpressora.GetNome: string;
begin
  Result := FNome;
end;

procedure TImpressora.SetAberta(Value: Boolean);
begin
  FAberta := Value;
end;

end.
