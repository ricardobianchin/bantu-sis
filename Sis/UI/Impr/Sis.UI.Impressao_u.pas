unit Sis.UI.Impressao_u;

interface

uses Sis.UI.Impressao, Sis.Usuario;

type
  TImpressao = class(TInterfacedObject, IImpressao)
  private
    FImpressoraNome: string;
    FUsuarioId: integer;
    FUsuarioNomeExib: string;

  protected
    property ImpressoraNome: string read FImpressoraNome;
    property UsuarioId: integer read FUsuarioId;
    property UsuarioNomeExib: string read FUsuarioNomeExib;

    procedure GereInicio; virtual;
    procedure GereCabec; virtual;
    procedure GereTexto; virtual;
    procedure GereRodape; virtual;
    procedure GereFim; virtual;
    procedure EnvieImpressao; virtual;
    function GetDtDoc: TDateTime; virtual;
    function GetDocTitulo: string; virtual; abstract;
    function GetAtivo: Boolean; virtual;

    property Ativo: Boolean read GetAtivo;
  public
    procedure Imprima; virtual;
    constructor Create(pImpressoraNome: string; pUsuarioId: integer; pUsuarioNomeExib: string);
  end;

implementation

uses Sis.Sis.Constants;

{ TImpressao }

constructor TImpressao.Create(pImpressoraNome: string; pUsuarioId: integer; pUsuarioNomeExib: string);
begin
  FImpressoraNome := pImpressoraNome;
  FUsuarioId := pUsuarioId;
  FUsuarioNomeExib := pUsuarioNomeExib;
end;

procedure TImpressao.EnvieImpressao;
begin

end;

procedure TImpressao.GereCabec;
begin

end;

procedure TImpressao.GereFim;
begin

end;

procedure TImpressao.GereInicio;
begin

end;

procedure TImpressao.GereRodape;
begin

end;

procedure TImpressao.GereTexto;
begin

end;

function TImpressao.GetAtivo: Boolean;
begin
  Result := FImpressoraNome <> '';
end;

function TImpressao.GetDtDoc: TDateTime;
begin
  Result :=  DATA_ZERADA;
end;

procedure TImpressao.Imprima;
begin
  GereInicio;
  GereTexto;
  GereFim;
  if Ativo then
    EnvieImpressao;
end;

end.
